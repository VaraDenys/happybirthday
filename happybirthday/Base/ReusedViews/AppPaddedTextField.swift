//
//  PaddedTextField.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit

class AppPaddedTextField: UITextField {
    var textInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override var inputAssistantItem: UITextInputAssistantItem {
        let item = super.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        return item
    }
}
