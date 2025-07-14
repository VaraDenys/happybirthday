//
//  Date+App.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import Foundation

extension Date {
    static func yearsAgo(_ yearsAgo: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: -yearsAgo, to: Date())
    }

    func timeSinceNowInShifts() -> (value: Int, unit: String) {
        let calendar = Calendar.current
        let now = Date()

        guard self <= now else {
            return (0, "months")
        }

        let components = calendar.dateComponents([.year, .month], from: self, to: now)

        if let years = components.year, years >= 1 {
            let unit = years == 1 ? "YEAR" : "YEARS"
            return (years, unit)
        } else if let months = components.month, months >= 1 {
            let unit = months == 1 ? "MONTH" : "MONTHS"
            return (months, unit)
        } else {
            return (0, "MONTH")
        }
    }
}
