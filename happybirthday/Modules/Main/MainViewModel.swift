//
//  MainViewModel.swift
//  HappyBirthday
//
//  Created by mac on 10.07.2025.
//

import Foundation
import UIKit

class MainViewModel: AppViewModel {
    private var state = MainViewState(imageName: nil, imageSelected: false)
    private var selectedImage: UIImage?
    var onDidChangeValues: ((MainViewState) -> Void)?
    var onDidError: ((AppErrorType) -> Void)?

    func onDidRemoveImageButtonTapped() {
        self.selectedImage = nil
        self.state.imageName = nil
        self.state.imageSelected = false
        self.onDidChangeValues?(self.state)
    }

    func handlePickedImage(_ image: UIImage, name: String?) {
        self.selectedImage = image
        self.state.imageName = name
        self.state.imageSelected = true
        self.onDidChangeValues?(self.state)
    }

    func onDidErrorOccured(_ error: AppErrorType) {
        self.onDidError?(error)
    }

    func getAppName() -> String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    func getMinimumDate() -> Date? {
        Date.yearsAgo(12)
    }
}
