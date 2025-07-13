//
//  ChildInfo.swift
//  happybirthday
//
//  Created by mac on 13.07.2025.
//

import  Foundation
import UIKit

struct ChildInfo {
    var name: String
    var date: Date
    var image: UIImage?

    init() {
        self.name = ""
        self.date = Date()
        self.image = nil
    }
}
