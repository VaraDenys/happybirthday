//
//  MainViewState.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit

struct MainViewState {
    var childName: String?
    var imageName: String?
    var forwardButtonActivated: Bool
    var date: Date
    var image: UIImage?

    init() {
        self.childName = ""
        self.imageName = nil
        self.forwardButtonActivated = false
        self.date = Date()
        self.image = nil
    }
}
