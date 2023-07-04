//
//  ContentView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: TransactionViewModel
    
    var body: some View {
        if vm.isActive {
            ZStack {
                //SideView()
                
                HomeView()
                
                WelcomePage()
                    .offset(y: vm.isNewUser ? 0 : -UIScreen.main.bounds.height)
            }
        } else {
            SplashView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TransactionViewModel())
    }
}
