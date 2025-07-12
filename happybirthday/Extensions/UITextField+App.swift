//
//  UITextField+App.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit

extension UITextField {
    func setAppStyle(with placeholder: String) {
        self.placeholder = placeholder
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appMainViewSecond.cgColor
        self.textColor = .appText
    }
}
