//
//  TransactionModel.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import Foundation
import SwiftUIFontIcon

struct Transaction: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    var amount: Double
    
    var signedAmount: Double {
        return isExpense == true ? -amount : amount
    }
    
    var month: String {
        parsedDate.formatted(.dateTime.year().month(.wide))
    }
    
    var date: String
    
    var parsedDate: Date {
        return date.toDate() ?? Date()
    }
    
    var category: String
    var isExpense: Bool
    
    var icon: FontAwesomeCode {
        switch category {
        case "Transport" : return .bus
        case "Food": return .utensils
        case "Home": return .home
        case "Entertainment": return .film
        case "Bills": return .money_bill_alt
        case "Shopping": return .shopping_cart
        case "Pets": return .dog
        case "Love": return .heart
        case "Outdoor Food": return .hamburger
        case "Income": return .dollar_sign
        default:
            return .question
        }
    }
}

let categories = [
    "Transport",
    "Food",
    "Entertainment",
    "Home",
    "Bills",
    "Shopping",
    "Pets",
    "Love",
    "Outdoor Food"
]

//enum Categories: String {
//    case transport = "Transport"
//    case food = "Food"
//    case entertainment = "Entertainment"
//    case home = "Home"
//    case bills = "Bills"
//    case shopping = "Shopping"
//    case pets = "Pets"
//    case love = "Love"
//    case outDoorFood = "Outdoor Food"
//}
