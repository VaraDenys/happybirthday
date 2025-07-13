//
//  String+App.swift
//  happybirthday
//
//  Created by mac on 13.07.2025.
//

extension String {
    func cleanedSpaces() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let reduced = trimmed.replacingOccurrences(of: "\\s{2,}", with: " ", options: .regularExpression)
        return reduced
    }
}
