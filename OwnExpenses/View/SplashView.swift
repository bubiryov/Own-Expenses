//
//  SplashView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 09.02.2023.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var vm: TransactionViewModel
    @State private var opacity = 0.0
    @State private var size = 0.7
    
    var body: some View {
        VStack {
            VStack {
//                Image("appstore")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 150)
                
                Text("Expenses tracker")
                    .font(Font.custom("SnellRoundhand-Black", size: 26))
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    self.size = 1
                    self.opacity = 1
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    vm.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(TransactionViewModel())
    }
}
