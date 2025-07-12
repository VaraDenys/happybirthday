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
    }

    private let appNameLabel = UILabel()
    private let stackView = UIStackView()
    private let nameTextField = AppPaddedTextField()
    private let dateTextField = AppPaddedTextField()
    private let datePicker = UIDatePicker()
    private let selectImageButton = UIButton()
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .appMainViewBackground

        self.setupAppNameLabel()
        self.setupStackView()
        self.setupButton()
    }

    // MARK: - overrided methods

    override func addSubviews() {
        self.view.addSubview(self.appNameLabel)
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.button)
        self.stackView.addArrangedSubview(self.nameTextField)
        self.stackView.addArrangedSubview(self.dateTextField)
        self.stackView.addArrangedSubview(self.selectImageButton)
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
        self.button.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.verticalOffset)
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
        self.setupDatePickerField()
        self.setupSelectImageButton()
    }

    private func setupDatePickerField() {
        self.dateTextField.inputView = datePicker
        self.dateTextField.setAppStyle(with: "Select date")

        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.date = Date()
        self.datePicker.maximumDate = Date()
        self.datePicker.minimumDate = self.viewModel.getMinimumDate()
        self.datePicker.backgroundColor = .white

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        self.dateTextField.inputAccessoryView = toolbar
    }

    private func setupSelectImageButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Select image"
        configuration.contentInsets = Constants.buttonInsets
        configuration.background.strokeColor = .appMainViewSecond
        configuration.background.strokeWidth = 1
        self.selectImageButton.configuration = configuration
    }

    private func setupButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = Constants.buttonInsets
        configuration.title = "Go ahead!"
        configuration.background.strokeColor = .appMainViewSecond
        configuration.background.strokeWidth = 1
        self.button.configuration = configuration
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    

    @objc private func doneTapped() {
        dateTextField.resignFirstResponder()
    }

    @objc private func buttonTapped() {}
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
