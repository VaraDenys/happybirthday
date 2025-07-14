//
//  MainViewModel.swift
//  HappyBirthday
//
//  Created by mac on 10.07.2025.
//

import Foundation
import UIKit

class MainViewModel: AppViewModel {
    private var state = MainViewState()
    private var childInfo = ChildInfo()
    var navigateToNextController: ((ChildInfo) -> Void)?
    var onDidChangeValues: ((MainViewState) -> Void)?
    var onDidError: ((AppErrorType) -> Void)?

    // MARK: - public methods

    func forwardButtonTapped() {
        let validationResult = self.validateData()
        switch validationResult {
        case .success(let success):
            if success {
                self.navigateToNextController?(self.childInfo)
            }
        case .failure(let error):
            self.onDidError?(error)
        }
    }

    func nameWasEntered(_ name: String?) {
        let clearedName = name?.cleanedSpaces()
        self.childInfo.name = clearedName ?? ""
        self.state.childName = clearedName
        self.state.forwardButtonActivated = !(name?.isEmpty ?? true)
        self.onDidChangeValues?(state)
    }

    func onDidRemoveImageButtonTapped() {
        self.childInfo.image = nil
        self.state.imageName = nil
        self.state.imageSelected = false
        self.onDidChangeValues?(self.state)
    }

    func handlePickedImage(_ image: UIImage, name: String?) {
        self.childInfo.image = image
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

    func dateWasChanges(_ date: Date) {
        self.childInfo.date = date
    }

    // MARK: - private methods

    private func validateData() -> Result<Bool, AppErrorType> {
        guard !self.childInfo.name.filter({ $0 != " " }).isEmpty else {
            return .failure(.emptyNameField)
        }
        return .success(true)
    }
}
