//
//  BirthdayScreenType.swift
//  happybirthday
//
//  Created by mac on 14.07.2025.
//

enum BirthdayScreenType: String, CaseIterable {
    case crane = "crane_variant"
    case elephant = "elephant_variant"
    case fox = "fox_variant"

    func getFrontImageName() -> String {
        self.rawValue
    }

    func getFallbackFaceImageName() -> String {
        "face_" + self.rawValue
    }

    func getCameraIconName() -> String {
        "camera_" + self.rawValue
    }

    func getBackgroundColorName() -> String {
        self.rawValue + "_background"
    }

    func getCircleBackgroundColorName() -> String {
        self.rawValue + "_circle_background"
    }

    func getBorderColorName() -> String {
        self.rawValue + "_border"
    }
}
