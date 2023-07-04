//
//  CardView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 04.02.2023.
//

import SwiftUI

struct MainCard: View {
    @EnvironmentObject var vm: TransactionViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        ZStack {
            Card()
            
            TextWithBalance()
            
            GearOnCard()
        }
        .frame(width: 350, height: UIScreen.main.bounds.height * 0.25)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCard()
            .padding(.horizontal)
            .environmentObject(TransactionViewModel())
    }
}

struct Card: View {
    @EnvironmentObject var vm: TransactionViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(vm.allColors[vm.indexColor])
    }
}

struct TextWithBalance: View {
    @EnvironmentObject var vm: TransactionViewModel
    var body: some View {
        Text(vm.summary(), format: .currency(code: "UAH"))
            .foregroundColor(.white)
            .font(.title2)
            .bold()
    }
}

struct GearOnCard: View {
    @EnvironmentObject var vm: TransactionViewModel
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .foregroundColor(.white.opacity(0.5))
                    .font(.title)
                    .bold()
                    .padding()
                    .onTapGesture {
                        vm.showColorMenu.toggle()
                    }
            }
            Spacer()
        }
    }
}
