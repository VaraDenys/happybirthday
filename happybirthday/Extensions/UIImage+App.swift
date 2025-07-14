//
//  UIImage+App.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import UIKit

extension UIImage {
    func scaled(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
