//
//  ConstraintMaker+App.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

import SnapKit

extension ConstraintMaker {
    func aspectRatio(_ width: CGFloat, by height: CGFloat, self instance: ConstraintView, priority: Int = 1000) {
        self.aspectRatio(width / height, self: instance, priority: priority)
    }

    func aspectRatio(_ ratio: CGFloat, self instance: ConstraintView, priority: Int = 1000) {
        self.width.equalTo(instance.snp.height).multipliedBy(ratio).priority(priority)
    }
}
