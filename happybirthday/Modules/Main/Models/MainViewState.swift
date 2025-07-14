//
//  MainViewState.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

struct MainViewState {
    var childName: String?
    var imageName: String?
    var imageSelected: Bool
    var forwardButtonActivated: Bool

    init() {
        self.childName = ""
        self.imageName = nil
        self.imageSelected = false
        self.forwardButtonActivated = false
    }
}
