//
//  UIViewController+App.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import UIKit

extension UIViewController {
    func shareScreenshot(hiding viewsToHide: [UIView] = []) {
        guard let screenshot = captureScreenshot(hiding: viewsToHide) else {
            return
        }

        let activityVC = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view

        present(activityVC, animated: true)
    }

    private func captureScreenshot(hiding viewsToHide: [UIView] = []) -> UIImage? {
        viewsToHide.forEach { $0.isHidden = true }
        
        for view in viewsToHide {
            view.isHidden = true
        }
        view.layoutIfNeeded()

        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let image = renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        viewsToHide.forEach { $0.isHidden = false }
        return image
    }
}
