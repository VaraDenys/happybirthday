//
//  ShowImageView.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import UIKit
import SnapKit

class ShowImageView: UIView {
    private struct Constants {
        static let cameraIconSize: CGFloat = 36
        static let circleViewBorderWidth: CGFloat = 7
        static let fallbackImageScale: CGFloat = 0.54
    }

    private let circleView = CircleView()
    private let imageView = UIImageView()
    private let cameraIconView = UIImageView()

    private var cameraCenterXConstraint: Constraint?
    private var cameraCenterYConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupInitialConstraints()
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = circleView.bounds.width / 2
        guard radius > 0 else { return }
        
        let angle: CGFloat = 45 * .pi / 180
        let offsetX = (cos(angle) * radius) - (Constants.circleViewBorderWidth / 2)
        let offsetY = (-sin(angle) * radius) + (Constants.circleViewBorderWidth / 2)
        
        self.cameraCenterXConstraint?.update(offset: offsetX)
        self.cameraCenterYConstraint?.update(offset: offsetY)
    }

    // MARK: - public methods

    func configure(with image: UIImage?, type: BirthdayScreenType) {
        self.setupImage(image, fallbackImageName: type.getFallbackFaceImageName())
        self.cameraIconView.image = UIImage(named: type.getCameraIconName())
        self.setupColors(with: type)
    }
    
    // MARK: - private methods
    
    private func addSubviews() {
        self.addSubview(self.circleView)
        self.addSubview(self.cameraIconView)
    }
    
    private func setupInitialConstraints() {
        self.circleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.cameraIconView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.cameraIconSize)
            self.cameraCenterXConstraint = make.centerX.equalTo(circleView.snp.centerX).constraint
            self.cameraCenterYConstraint = make.centerY.equalTo(circleView.snp.centerY).constraint
        }
    }

    private func setupViews() {
        self.circleView.layer.borderWidth = Constants.circleViewBorderWidth
        self.circleView.clipsToBounds = true
        self.cameraIconView.contentMode = .scaleAspectFit
        self.imageView.contentMode = .scaleAspectFill
    }

    private func setupImage(_ image: UIImage?, fallbackImageName: String) {
        self.circleView.subviews.forEach { $0.removeFromSuperview() }
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        self.circleView.addSubview(imageView)
        if let image {
            imageView.image = image
            imageView.snp.remakeConstraints { $0.edges.equalToSuperview() }
        } else {
            imageView.image = UIImage(named: fallbackImageName)
            imageView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.height.width.equalToSuperview().multipliedBy(Constants.fallbackImageScale)
            }
        }
    }

    private func setupColors(with type: BirthdayScreenType) {
        self.circleView.backgroundColor = UIColor(named: type.getCircleBackgroundColorName())
        self.circleView.layer.borderColor = UIColor(named: type.getBorderColorName())?.cgColor
    }
}
