//
//  MainViewModel.swift
//  HappyBirthday
//
//  Created by mac on 10.07.2025.
//

import Foundation

class MainViewModel: AppViewModel {
    func getAppName() -> String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    func getMinimumDate() -> Date? {
        Date.yearsAgo(12)
    }
}
