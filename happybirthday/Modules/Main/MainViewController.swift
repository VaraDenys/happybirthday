//
//  ViewController.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit
import SnapKit

class MainViewController: AppViewController<MainViewModel> {
    private struct Constants {
        static let appNameFontSize: CGFloat = 24
        static let horizontalnset: CGFloat = 16
        static let verticalOffset: CGFloat = 16
        static let buttonInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        static let stackViewSpacing: CGFloat = 32
        static let buttonTitleSize: CGFloat = 18
        static let errorLabelOffset: CGFloat = 18
    }

    private let appNameLabel = UILabel()
    private let stackView = UIStackView()
    private let nameTextField = AppPaddedTextField()
    private let datePicker = UIDatePicker()
    private let imageSelectionView = ImageSelectionView()
    private let errorLabel = UILabel()
    private let forwardButton = UIButton()
    private var imagePickerCoordinator: ImagePickerCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appMainViewBackground

        self.setupAppNameLabel()
        self.setupStackView()
        self.setupButton()
        self.setupErrorLabel()
    }

    // MARK: - overrided methods

    override func addSubviews() {
        self.view.addSubview(self.appNameLabel)
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.forwardButton)
        self.view.addSubview(self.errorLabel)
        self.stackView.addArrangedSubview(self.nameTextField)
        self.stackView.addArrangedSubview(self.datePicker)
        self.stackView.addArrangedSubview(self.imageSelectionView)
    }

    override func setupConstraints() {
        self.appNameLabel.snp.remakeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.verticalOffset)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalnset)
        }
        self.stackView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalnset)
            $0.center.equalToSuperview()
        }
        self.forwardButton.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.verticalOffset)
        }
        self.errorLabel.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalnset)
            $0.bottom.equalTo(self.forwardButton.snp.top).offset(-Constants.errorLabelOffset)
        }
    }

    override func binding() {
        self.viewModel.onDidChangeValues = { [weak self] state in
            self?.imageSelectionView.update(with: state.imageName, imageSelected: state.imageSelected)
        }

        self.viewModel.onDidError = { [weak self] error in
            self?.errorLabel.text = error.rawValue
            self?.errorLabel.isHidden = false
        }

        self.imageSelectionView.onDidSelectImageButtonTapped = { [weak self] in
            guard let self else { return }
            self.imagePickerCoordinator = ImagePickerCoordinator(presentingVC: self)
            self.imagePickerCoordinator?.delegate = self
            self.imagePickerCoordinator?.presentPicker()
        }

        self.imageSelectionView.onDidRemoveImageButtonTapped = { [weak self] in
            self?.viewModel.onDidRemoveImageButtonTapped()
        }
    }

    // MARK: - private methods

    private func setupAppNameLabel() {
        self.appNameLabel.textColor = .appText
        self.appNameLabel.font = .systemFont(ofSize: Constants.appNameFontSize)
        self.appNameLabel.textAlignment = .center
        self.appNameLabel.text = self.viewModel.getAppName()
        self.nameTextField.returnKeyType = .done
        self.nameTextField.delegate = self
        self.nameTextField.autocorrectionType = .no
        self.nameTextField.keyboardType = .default
    }

    private func setupStackView() {
        self.stackView.axis = .vertical
        self.stackView.spacing = Constants.stackViewSpacing

        self.nameTextField.setAppStyle(with: "Enter the name")
        self.setupDatePicker()
    }

    private func setupDatePicker() {
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.date = Date()
        self.datePicker.maximumDate = Date()
        self.datePicker.minimumDate = viewModel.getMinimumDate()
        self.datePicker.datePickerMode = .date

    }

    private func setupButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = Constants.buttonInsets
        configuration.title = "Go ahead!"
        configuration.background.strokeColor = .appMainViewSecond
        configuration.background.strokeWidth = 1
        self.forwardButton.configuration = configuration
        self.forwardButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func setupErrorLabel() {
        self.errorLabel.textColor = .red
        self.errorLabel.textAlignment = .center
        self.errorLabel.numberOfLines = 0
        self.errorLabel.isHidden = true
    }

    @objc private func buttonTapped() {}
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MainViewController: ImagePickerCoordinatorDelegate {
    func imagePickerCoordinator(_ coordinator: ImagePickerCoordinator,
                                didPick result: (image: UIImage, name: String?)?,
                                error: AppErrorType?) {
        guard error == nil else {
            viewModel.onDidErrorOccured(error!)
            return
        }
        guard let result else {
            return
        }
        viewModel.handlePickedImage(result.image, name: result.name)
    }

    func imagePickerDidCancel() {
        self.imagePickerCoordinator = nil
    }
}
