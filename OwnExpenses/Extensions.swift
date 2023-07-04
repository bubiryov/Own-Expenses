//
//  Extensions.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 01.02.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let text = Color("Text")
    static let icon = Color("Icon")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension String {
    func toDate(withFormat format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}



//extension Date: Strideable {
//    func formatted() -> String {
//        return self.formatted(.dateTime.day().month().year())
//    }
//}
