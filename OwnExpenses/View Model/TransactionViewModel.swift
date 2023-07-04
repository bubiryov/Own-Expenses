//
//  TransactionViewModel.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import Foundation
import Collections
import SwiftUI

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

class TransactionViewModel: ObservableObject {
    @Published var showColorMenu = false
    @Published var showAddView = false
    @Published var showChart = false
    @Published var isActive = false
    @Published var allTransactions: [Transaction] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(allTransactions) {
                UserDefaults.standard.set(encoded, forKey: "TRANSACTION_KEY")
            }
        }
    }
    
    
    @Published var allColors = [
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2039215686, green: 0.1803921569, blue: 0.1647058824, alpha: 1)), Color(#colorLiteral(red: 0.2588235294, green: 0.3607843137, blue: 0.462745098, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5607843137, green: 0.7764705882, blue: 0.9921568627, alpha: 1)), Color(#colorLiteral(red: 0.8784313725, green: 0.768627451, blue: 0.9921568627, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.5803921569, blue: 0.5098039216, alpha: 1)), Color(#colorLiteral(red: 0.4901960784, green: 0.4666666667, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1333333333, green: 0.7568627451, blue: 0.7647058824, alpha: 1)), Color(#colorLiteral(red: 0.9921568627, green: 0.7333333333, blue: 0.1764705882, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8039215686, blue: 0.6470588235, alpha: 1)), Color(#colorLiteral(red: 0.9333333333, green: 0.3019607843, blue: 0.3725490196, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    ]
    
    @AppStorage("color") var indexColor = 1
    @AppStorage("entry_sum") var entrySum: Double = 0
    @AppStorage("isNew") var isNewUser = true
                        
    func summary() -> Double {
        var sum: Double = 0
        for transaction in allTransactions {
            sum += transaction.signedAmount
        }
        sum += entrySum
        return sum
    }
    
    func deleteAllData() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isNewUser = true
            allTransactions = []
            entrySum = 0
        }
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !allTransactions.isEmpty else {
            return [:]
        }
        let groupedTransactions = TransactionGroup(grouping: allTransactions.reversed()) { $0.month }
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !allTransactions.isEmpty else  {
            return []
        }
        
        let today = Date()
        let dateInterval = Calendar.current.dateInterval(of: .weekOfMonth, for: today)!
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, through: today, by: 60*60*24) {
            let dailyExpenses = allTransactions.filter { $0.parsedDate == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            cumulativeSum.append((date.toString(), sum))
        }
        return cumulativeSum
    }
    
            
    init() {
        if let transactions = UserDefaults.standard.data(forKey: "TRANSACTION_KEY") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Transaction].self, from: transactions) {
                self.allTransactions = decoded
                return
            }
        }
    }
}
