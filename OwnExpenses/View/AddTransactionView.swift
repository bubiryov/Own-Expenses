//
//  AddTransactionView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount: String = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Amount", text: $amount)
                    .padding()
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding()


            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
