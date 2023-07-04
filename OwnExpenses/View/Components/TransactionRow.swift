//
//  TransactionRow.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            CircleView(transaction: transaction)
            
            DateTittleView(transaction: transaction)
            
            Spacer()
            
            SummaryView(transaction: transaction)
        }        
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: Transaction(amount: 100, date: "", category: "", isExpense: false))
    }
}

struct CircleView: View {
    var transaction: Transaction
    var body: some View {
        Circle()
            .fill(Color.secondary)
            .frame(width: 50)
            .overlay {
                FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.white)
            }
    }
}

struct DateTittleView: View {
    var transaction: Transaction
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(transaction.category)
                .font(.title3)
                .bold()
                .lineLimit(1)
            Text(transaction.parsedDate, format: .dateTime.day().month().year())
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct SummaryView: View {
    var transaction: Transaction
    var body: some View {
        Text(transaction.signedAmount, format: .currency(code: "UAH"))
            .bold()
            .foregroundColor(transaction.isExpense == true ? Color.red.opacity(1) : .primary)
    }
}
