//
//  BirthdayHeaderView.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import UIKit
import SnapKit

class BirthdayHeaderView: UIView {
    private struct Constants {
        static let numberImageTopOffset: CGFloat = 13
        static let numberImageHeight: CGFloat = 90
        static let bottomLabelOffset: CGFloat = 14
        static let swirlOffset: CGFloat = 22
        static let swirlHeight: CGFloat = 44
    }
    private let topLabel = UILabel()
    private let numberImageView = UIImageView()
    private let bottomLabel = UILabel()
    private let leftSwirlImageView = UIImageView(image: .swirlLeft)
    private let rightSwirlImageView = UIImageView(image: .swirlRight)
    private var numberImageWidthConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupConstraints()
        self.setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - public methods

    func configure(numberImage: UIImage?, topTitle: String, bottomTitle: String) {
        guard let numberImage else { return }
        self.numberImageView.image = numberImage
        let ratio = numberImage.size.width / numberImage.size.height
        let width = Constants.numberImageHeight * ratio
        self.numberImageWidthConstraint?.update(offset: width)
        self.topLabel.text = topTitle
        self.bottomLabel.text = bottomTitle
    }
    
    // MARK: - private methods
    
    private func addSubviews() {
        self.addSubview(self.topLabel)
        self.addSubview(self.numberImageView)
        self.addSubview(self.bottomLabel)
        self.addSubview(self.leftSwirlImageView)
        self.addSubview(self.rightSwirlImageView)
    }

    private func setupConstraints() {
        self.topLabel.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        self.numberImageView.snp.remakeConstraints {
            $0.top.equalTo(self.topLabel.snp.bottom).offset(Constants.numberImageTopOffset)
            $0.height.equalTo(Constants.numberImageHeight)
            self.numberImageWidthConstraint = $0.width.equalTo(Constants.numberImageHeight).constraint
            $0.centerX.equalToSuperview()
        }
        self.bottomLabel.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.numberImageView.snp.bottom).offset(Constants.bottomLabelOffset)
            $0.bottom.equalToSuperview()
        }
        let imageSize = self.leftSwirlImageView.image?.size ?? .zero
        let ratio = imageSize.width / imageSize.height
        self.leftSwirlImageView.snp.remakeConstraints {
            $0.trailing.equalTo(self.numberImageView.snp.leading).offset(-Constants.swirlOffset)
            $0.height.equalTo(Constants.swirlHeight)
            $0.aspectRatio(ratio, self: self.leftSwirlImageView)
            $0.centerY.equalTo(self.numberImageView)
        }
        self.rightSwirlImageView.snp.remakeConstraints {
            $0.leading.equalTo(self.numberImageView.snp.trailing).offset(Constants.swirlOffset)
            $0.height.equalTo(Constants.swirlHeight)
            $0.aspectRatio(ratio, self: self.leftSwirlImageView)
            $0.centerY.equalTo(self.numberImageView)
        }
    }

    private func setupLabels() {
        [self.topLabel, self.bottomLabel].forEach {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 21)
            $0.textColor = .appText
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
    }
}
