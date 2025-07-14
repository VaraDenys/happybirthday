//
//  DefaultsManager.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import Foundation

private enum Keys: String {
    case userName
    case dateOfBirth
    case imageFileName
}

enum DefaultsManager {
    static var userName: String? {
        get { return string(for: .userName) }
        set(val) { set(val, for: .userName) }
    }

    static var dateOfBirth: Date? {
        get { return date(for: .dateOfBirth) }
        set(val) { set(val, for: .dateOfBirth) }
    }

    static var imageFileName: String? {
        get { return string(for: .imageFileName) }
        set(val) { set(val, for: .imageFileName) }
    }

    private static func set(_ value: Any?, for key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    private static func string(for key: Keys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }

    private static func date(for key: Keys) -> Date? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Date
    }
}
