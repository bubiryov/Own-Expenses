//
//  TransactionList.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var vm: TransactionViewModel
    var body: some View {
        FullList()
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
            .environmentObject(TransactionViewModel())
    }
}

struct FullList: View {
    @EnvironmentObject var vm: TransactionViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(vm.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    Section {
                        ForEach(transactions, id: \.id) { transaction in
                            TransactionRow(transaction: transaction)
                            
                        }
                    } header: {
                        Text(month)
                    }
                    
                }
                .onDelete { index in
                    let theItem = vm.allTransactions.reversed()[index.first!]
                    if let ndx = vm.allTransactions.firstIndex(of: theItem) {
                        vm.allTransactions.remove(at: ndx)
                    }
                }
            }
            .listSectionSeparator(.hidden)
            .padding(.top)
            .listStyle(.plain)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .bold()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure?"),
                          message: Text("This will delete all data"),
                          primaryButton:
                            .destructive(Text("Delete")) {
                                vm.deleteAllData()
                                dismiss()
                            },
                          secondaryButton: .cancel())
                }
            }
        }
        
    }
}
