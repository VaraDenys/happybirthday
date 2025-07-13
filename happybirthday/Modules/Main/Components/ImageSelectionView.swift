//
//  ImageSelectionView.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit
import SnapKit

class ImageSelectionView: UIView {
    private struct Constants {
        static let labelInsets: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        static let buttonInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        static let removeButtonOffset: CGFloat = 8
    }
    private let selectImageButton = UIButton()
    private let fileChosenLabel = AppPaddedLabel()
    private let removeImageButton = UIButton()
    var onDidSelectImageButtonTapped: (() -> Void)?
    var onDidRemoveImageButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupConstraints()
        self.setupSelectImageButton()
        self.setupFileChosenLabel()
        self.setupRemoveImageButton()
        self.update(with: nil, imageSelected: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - public methods

    func update(with fileName: String?, imageSelected: Bool) {
        self.selectImageButton.isHidden = imageSelected
        self.fileChosenLabel.isHidden = !imageSelected
        self.removeImageButton.isHidden = !imageSelected
        if imageSelected {
            self.fileChosenLabel.text = fileName?.isEmpty ?? true ? "🖼️" : fileName
        }
    }

    // MARK: - private methods

    private func addSubviews() {
        self.addSubview(self.selectImageButton)
        self.addSubview(self.fileChosenLabel)
        self.addSubview(self.removeImageButton)
    }

    private func setupConstraints() {
        self.selectImageButton.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        self.removeImageButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(self.fileChosenLabel.snp.height)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        self.fileChosenLabel.snp.remakeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualTo(self.removeImageButton.snp.leading).offset(-Constants.removeButtonOffset)
        }
    }

    private func setupSelectImageButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Select image"
        configuration.contentInsets = Constants.buttonInsets
        configuration.background.strokeColor = .appMainViewSecond
        configuration.background.strokeWidth = 1
        self.selectImageButton.configuration = configuration
        self.selectImageButton.addTarget(self, action: #selector(selectmageButtonTapped), for: .touchUpInside)
    }

    private func setupFileChosenLabel() {
        self.fileChosenLabel.numberOfLines = 1
        self.fileChosenLabel.textInsets = Constants.labelInsets
        self.fileChosenLabel.layer.cornerRadius = 4
        self.fileChosenLabel.layer.borderWidth = 1
        self.fileChosenLabel.layer.borderColor = UIColor.appMainViewSecond.cgColor
        self.fileChosenLabel.textColor = .appText
    }

    private func setupRemoveImageButton() {
        self.removeImageButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.removeImageButton.addTarget(self, action: #selector(removeImageButtonTapped), for: .touchUpInside)
    }

    @objc private func selectmageButtonTapped() {
        self.onDidSelectImageButtonTapped?()
    }

    @objc private func removeImageButtonTapped() {
        self.onDidRemoveImageButtonTapped?()
    }
}
