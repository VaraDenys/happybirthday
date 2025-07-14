//
//  BirthdayViewController.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import UIKit
import SnapKit

class BirthdayViewController: AppViewController<BirthdayViewModel> {
    private struct Constants {
        static let topOffset: CGFloat = 20
        static let showImageViewOffset: CGFloat = 15
        static let horisontalInsets: CGFloat = 50
        static let logoImageHeight: CGFloat = 20
        static let initialFrontImageHeight: CGFloat = 150
        static let logoOffset: CGFloat = 15
        static let backButtonOffset: CGFloat = 10
        static let backButtonSize: CGFloat = 32
        static let shareViewBottomOffset: CGFloat = 45
    }
    private let headerView = BirthdayHeaderView()
    private let backButton = UIButton()
    private let showImageView = ShowImageView()
    private let logoImageView = UIImageView(image: UIImage(named: "nanit_logo"))
    private let frontImageView = UIImageView()
    private let shareScreenshotButton = ShareScreenshotButton()

    private var frontImageHeightConstraint: Constraint?
    private var hasUpdatedFrontImageHeight = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.viewModel.fetchData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !hasUpdatedFrontImageHeight, frontImageView.image != nil {
            updateFrontImageHeight()
            hasUpdatedFrontImageHeight = true
        }
    }

    // MARK: - overrided methods

    override func addSubviews() {
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.showImageView)
        self.view.addSubview(self.logoImageView)
        self.view.addSubview(self.frontImageView)
        self.view.addSubview(self.shareScreenshotButton)
    }

    override func setupConstraints() {
        self.headerView.snp.remakeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.topOffset)
            $0.leading.trailing.equalTo(self.showImageView)
        }
        self.backButton.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(Constants.backButtonOffset)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.backButtonOffset)
            $0.height.width.equalTo(Constants.backButtonSize)
        }
        self.showImageView.snp.remakeConstraints {
            $0.top.equalTo(self.headerView.snp.bottom).offset(Constants.showImageViewOffset)
            $0.width.equalToSuperview().inset(Constants.horisontalInsets)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.showImageView.snp.width)
        }
        let logoSize = logoImageView.image?.size ?? .zero
        let logoRatio = logoSize.width / logoSize.height
        self.logoImageView.snp.remakeConstraints {
            $0.top.equalTo(self.showImageView.snp.bottom).offset(Constants.logoOffset)
            $0.centerX.equalTo(self.showImageView.snp.centerX)
            $0.height.equalTo(Constants.logoImageHeight)
            $0.aspectRatio(logoRatio, self: self.logoImageView)
        }
        self.frontImageView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            self.frontImageHeightConstraint = $0.height.equalTo(Constants.initialFrontImageHeight).constraint
        }
        self.shareScreenshotButton.snp.remakeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.shareViewBottomOffset)
            $0.centerX.equalToSuperview()
        }
    }

    override func binding() {
        self.viewModel.onDidChangeValues = { [weak self] data in
            self?.headerView.configure(numberImage: UIImage(named: data.numberImageName),
                                       topTitle: data.topTitle,
                                       bottomTitle: data.bottomTitle)
            self?.showImageView.configure(with: data.childImage,
                                          type: data.type)
            self?.view.backgroundColor = UIColor(named: data.type.getBackgroundColorName())
            self?.frontImageView.image = UIImage(named: data.type.getFrontImageName())
            self?.updateFrontImageHeight()
        }
    }

    // MARK: - private methods

    private func setupViews() {
        self.backButton.setImage(UIImage(named: "back_button"), for: .normal)
        self.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        self.logoImageView.contentMode = .scaleAspectFit
    }

    private func updateFrontImageHeight() {
        guard let imageSize = self.frontImageView.image?.size, imageSize.height > 0 else {
            return
        }
        let ratio = imageSize.height / imageSize.width
        let currentImageWidth = self.frontImageView.frame.width
        self.frontImageHeightConstraint?.update(offset: currentImageWidth * ratio)
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
