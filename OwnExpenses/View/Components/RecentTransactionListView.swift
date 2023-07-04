//
//  TransactionListView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI

struct RecentTransactionListView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var vm: TransactionViewModel
        
    var body: some View {
        VStack {
            ToolBarViews()
            
            RecentList()
        }
        .padding(.horizontal)
        .padding(.top)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .clear)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentTransactionListView()
            .environmentObject(TransactionViewModel())
    }
}

struct ToolBarViews: View {
    var body: some View {
        HStack {
            Text("Recent Transactions")
                .font(.title3)
                .bold()
            
            Spacer()
            
            NavigationLink {
                TransactionList()
                    .navigationTitle("All transactions")
            } label: {
                HStack {
                    Text("See all")
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(Color.primary)
            }
        }
        .padding(.bottom)
    }
}

/*
struct ListOfTransactions: View {
    var vm: TransactionViewModel
    var body: some View {
        ForEach(Array(vm.allTransactions.prefix(5).enumerated()), id: \.element) { index, transaction in
            TransactionRow(transaction: transaction)
            Divider()
                .opacity(index == 4 ? 0 : 1)
        }
    }
}
*/

struct RecentList: View {
    @EnvironmentObject var vm: TransactionViewModel
    var body: some View {
        ForEach(Array(vm.allTransactions.suffix(5).enumerated().reversed()), id: \.element) { index, transaction in
            TransactionRow(transaction: transaction)
            Divider()
                .opacity(index == 4 ? 0 : 1)
        }
    }
}
