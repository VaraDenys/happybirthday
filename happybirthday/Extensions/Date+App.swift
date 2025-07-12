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
}
