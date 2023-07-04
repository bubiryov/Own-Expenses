//
//  AddView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI

let buttons = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
    [".", "0"]
]

struct AddView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var vm: TransactionViewModel
    @State private var selectedCategory = "Transport"
    @State private var incomeCategory = "Salary"
    @State private var showKeyboard = false
    @State private var deleteSwipe: CGSize = .zero
    @State private var amount: String = "0"

        
    var body: some View {
        NavigationView {
            VStack {
                TextWithSum(amount: $amount, deleteSwipe: $deleteSwipe)
                
                Divider().background(.primary)
                
                PickerWithCategories(selectedCategory: $selectedCategory)
                
                Divider().background(.primary)
                    .padding(.bottom)
                
                NumPad(amount: $amount)
                
                HStack {
                    incomeButton
                    expenseButton
                }
            }
            .padding(.all, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.systemBackground)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "xmark")
                        .foregroundStyle(.primary)
                        .bold()
                        .onTapGesture {
                            vm.showAddView = false
                        }
                }
            }
        }
    }
    
    func addNewTransaction(isExpense: Bool) {
        guard let amount = Double(amount) else { return }
        let currentDate = Date()
        let dateString = currentDate.toString()
        guard amount != 0 else {
            self.amount = "0"
            vm.showAddView = false
            return
        }
        let newTransaction = Transaction(amount: amount, date: dateString, category: isExpense ? selectedCategory : "Income", isExpense: isExpense)
        vm.allTransactions.append(newTransaction)
        self.amount = "0"
        vm.showAddView = false
    }
    
    var incomeButton: some View {
        Button {
            addNewTransaction(isExpense: false)
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .fill(colorScheme == .light ? Color.black.opacity(0.5) : Color.white.opacity(0.5))
                .frame(height: 50)
                .frame(maxWidth: (UIScreen.main.bounds.width / 2)*0.7)
                .overlay {
                    Text("Income")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title2)
                        .bold()
                }
        }
    }
    
    var expenseButton: some View {
        Button {
            addNewTransaction(isExpense: true)
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .fill(colorScheme == .dark ? Color.white : Color.black)
                .frame(height: 50)
                .frame(maxWidth: (UIScreen.main.bounds.width / 2)*0.7)
                .overlay {
                    Text("Expense")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .font(.title2)
                        .bold()
                }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(TransactionViewModel())
    }
}

struct TextWithSum: View {
    @Binding var amount: String
    @Binding var deleteSwipe: CGSize
    var body: some View {
        HStack {
            Text(amount)
                .font(.system(size: 60))
                .bold()
                .foregroundColor(amount == "0" ? .secondary : .primary)
                .lineLimit(1)
                
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.0000001))
        .gesture(
            DragGesture()
                .onChanged{ value in
                    deleteSwipe = value.translation
                }
                .onEnded({ value in
                    if deleteSwipe.width < -70 {
                        let newString = amount.dropLast()
                        amount = String(newString)
                        if amount == "" {
                            amount = "0"
                            deleteSwipe = .zero
                        }
                        deleteSwipe = .zero
                    }
                })
        )
    }
}

struct PickerWithCategories: View {
    @Binding var selectedCategory: String
    var body: some View {
        Picker(selection: $selectedCategory, label: Text("Categories")) {
            ForEach(categories, id: \.self) { category in
                Text(category)
                    .bold()
                    .tag(category)
            }
        }
        .tint(.primary)
        .frame(maxWidth: .infinity)
        .frame(height: 25)
        .pickerStyle(.menu)
    }
}


