//
//  AddButtonView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 06.02.2023.
//

import SwiftUI

struct AddButtonView: View {
    var vm: TransactionViewModel
    var colorScheme: ColorScheme
    @Binding var buttonState: CGSize
    var body: some View {
        Button {
            //
        } label: {
            Circle()
                .fill(colorScheme == .light ? Color.black : Color.white)
                .frame(width: 70)
                .overlay {
                    Image(systemName: "plus")
                        .foregroundColor(.systemBackground)
                        .font(.title2)
                        .bold()
                }
        }
        .offset(x: buttonState.width, y: buttonState.height)
        .simultaneousGesture(
        DragGesture()
            .onChanged{ value in
                buttonState = value.translation
            }
            .onEnded { value in
                if buttonState.height < -450 && buttonState.height > -690 {
                    vm.showAddView = true
                    buttonState = .zero
                } else {
                    buttonState = .zero
                }
            }
        )
    }
}
/*
struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(vm: , colorScheme: <#ColorScheme#>, buttonState: <#Binding<CGSize>#>)
    }
}
*/
