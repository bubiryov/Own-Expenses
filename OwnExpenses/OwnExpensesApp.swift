//
//  OwnExpensesApp.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import SwiftUI

@main
struct OwnExpensesApp: App {
    @StateObject var vm = TransactionViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
