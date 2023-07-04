//
//  ChartView.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 08.02.2023.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var vm: TransactionViewModel
    
    var body: some View {
        let data = vm.accumulateTransactions()
        let total = data.last?.1 ?? 0

        VStack {
            CardView {
                VStack {
                    ChartLabel(total.formatted(.currency(code: "UAH")), type: .subTitle)
                        .padding()
                    LineChart()
                }
                .background(colorScheme == .dark ? .black : .white)
            }
            .data(vm.accumulateTransactions())
            .chartStyle(ChartStyle(
                backgroundColor: Color.blue.opacity(0.4),
                foregroundColor: ColorGradient(Color.blue.opacity(0.8))))
            .frame(width: 350, height: UIScreen.main.bounds.height * 0.25)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(TransactionViewModel())
    }
}
