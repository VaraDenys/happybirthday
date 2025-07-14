//
//  ShareScreenshotView.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import UIKit

class ShareScreenshotButton: UIButton {
    private struct Constants {
        static let horizontalOffset: CGFloat = 24
        static let verticalOffset: CGFloat = 12
        static let shareIconSize: CGFloat = 24
        static let spacing: CGFloat = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    // MARK: - Private methods
    
    private func setupButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Share the news"
        configuration.baseForegroundColor = .white
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
            return outgoing
        }
        let scaledImage = UIImage.shareIcon.scaled(to: CGSize(width: Constants.shareIconSize,
                                                      height: Constants.shareIconSize))
        configuration.image = scaledImage
        configuration.imagePlacement = .trailing
        configuration.imagePadding = Constants.spacing
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.verticalOffset,
            leading: Constants.horizontalOffset,
            bottom: Constants.verticalOffset,
            trailing: Constants.horizontalOffset
        )
        
        self.configuration = configuration
        self.backgroundColor = .shareScreenBackground
    }
}
