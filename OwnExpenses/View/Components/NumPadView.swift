//
//  NumPad.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 08.02.2023.
//

import SwiftUI

struct NumPad: View {
    @Binding var amount: String

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 30) {
                    ForEach(row, id: \.self) { button in
                        Button {
                            if self.amount == "0" {
                                amount = ""
                                self.amount += button
                            } else {
                                self.amount += button
                            }
                        } label: {
                            Text(button)
                                .font(.system(size: 40))
                                .frame(width: 80, height: 50)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

//struct NumPad_Previews: PreviewProvider {
//    static var previews: some View {
//        NumPad(amount:)
//    }
//}
