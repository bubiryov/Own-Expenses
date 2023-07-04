//
//  ColorsMenu.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 05.02.2023.
//

import SwiftUI

struct ColorsMenu: View {
    @EnvironmentObject var vm: TransactionViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
        
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<vm.allColors.count, id: \.self) { index in
                Circle()
                    .fill(vm.allColors[index])
                    .frame(width: 32)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.1)) {
                            vm.indexColor = index
                        }
                    }
                    .scaleEffect(index == vm.indexColor ? 1.5 : 0.8)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(.white.opacity(0.0001))
        .cornerRadius(30)
        .padding()
        .padding(.bottom, 7)
        .padding(.horizontal)
    }
}

struct ColorsBar_Previews: PreviewProvider {
    static var previews: some View {
        ColorsMenu()
            .environmentObject(TransactionViewModel())
    }
}
