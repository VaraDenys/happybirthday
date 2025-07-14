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
    var navigateToNextController: ((ChildInfo) -> Void)?
    var onDidChangeValues: ((MainViewState) -> Void)?
    var onDidError: ((AppErrorType) -> Void)?

    // MARK: - public methods

    func fetchData() {
        let imageInfo = ImageStore.shared.getImageInfo()
        self.state.childName = DefaultsManager.userName
        self.state.imageName = imageInfo.name
        self.state.date = DefaultsManager.dateOfBirth ?? Date()
        self.state.image = imageInfo.image
        let validationResult = self.validateData()
        switch validationResult {
        case .success(let value):
            self.state.forwardButtonActivated = value
        case .failure(_):
            self.state.forwardButtonActivated = false
        }
        self.onDidChangeValues?(state)
    }

    func forwardButtonTapped() {
        let validationResult = self.validateData()
        switch validationResult {
        case .success(let success):
            if success {
                let childInfo = ChildInfo(name: self.state.childName ?? "",
                                          date: self.state.date,
                                          image: self.state.image)
                self.navigateToNextController?(childInfo)
            }
        case .failure(let error):
            self.onDidError?(error)
        }
    }

    func nameWasEntered(_ name: String?) {
        let clearedName = name?.cleanedSpaces()
        self.state.childName = clearedName
        self.state.forwardButtonActivated = !(name?.isEmpty ?? true)
        DefaultsManager.userName = clearedName
        self.onDidChangeValues?(state)
    }

    func onDidRemoveImageButtonTapped() {
        self.state.imageName = nil
        self.state.image = nil
        ImageStore.shared.removeImage()
        self.onDidChangeValues?(self.state)
    }

    func handlePickedImage(_ image: UIImage, name: String?) {
        self.state.imageName = name
        self.state.image = image
        ImageStore.shared.save(image: image, named: name)
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
        self.state.date = date
        DefaultsManager.dateOfBirth = date
    }

    // MARK: - private methods

    private func validateData() -> Result<Bool, AppErrorType> {
        guard let name = self.state.childName,
              !name.filter({ $0 != " " }).isEmpty else {
            return .failure(.emptyNameField)
        }
        return .success(true)
    }
}
