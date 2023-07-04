//
//  HomeView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 06.02.2023.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var vm: TransactionViewModel
    @State private var buttonState: CGSize = .zero
    @State private var stateColors: CGSize = .zero

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ZStack {
                        MainCard()
                            .offset(x: !vm.showChart ? 0 : -UIScreen.main.bounds.width)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: vm.showChart)
                            .onTapGesture {
                                vm.showChart = true
                            }
                        
                        ChartView()
                            .offset(x: vm.showChart ? 0 : UIScreen.main.bounds.width)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: vm.showChart)
                            .onTapGesture {
                                vm.showChart = false
                            }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 7)
                    
                    RecentTransactionListView()
                        .cornerRadius(30)
                        .padding(.horizontal, 15)
                    
                    Spacer()
                }
                .navigationTitle("Expenses")
                .navigationBarTitleDisplayMode(.inline)                
            }
            .tint(.primary)
            
            
            AddButton(buttonState: $buttonState)
            
            Colors(stateColors: $stateColors)
 
            AddView()
                .offset(y: vm.showAddView ? .zero : UIScreen.main.bounds.height)
                .animation(.spring(response: 0.4, dampingFraction: 1), value: vm.showAddView)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TransactionViewModel())
    }
}

struct Colors: View {
    @EnvironmentObject var vm: TransactionViewModel
    @Binding var stateColors: CGSize
    var body: some View {
        VStack {
            Spacer()
            ColorsMenu()
                .offset(x: vm.showColorMenu ? 0 : UIScreen.main.bounds.width)
                .offset(x: stateColors.width)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: vm.showColorMenu)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: stateColors)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            stateColors = value.translation
                        }
                        .onEnded { value in
                            if stateColors.width < 0 {
                                stateColors = .zero
                            }
                            if stateColors.width > 30 {
                                stateColors = .zero
                                vm.showColorMenu = false
                            }
                        }
                )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AddButton: View {
    @EnvironmentObject var vm: TransactionViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var buttonState: CGSize
    var body: some View {
        VStack {
            Spacer()
            AddButtonView(vm: vm, colorScheme: colorScheme, buttonState: $buttonState)
                .offset(x: !vm.showColorMenu ? 0 : -UIScreen.main.bounds.width)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: vm.showColorMenu)
                .padding(.bottom, 30)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
