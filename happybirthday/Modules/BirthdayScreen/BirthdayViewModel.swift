//
//  BirthdayViewModel.swift
//  happybirthday
//
//  Created by mac on 13.07.2025.
//

import UIKit

class BirthdayViewModel: AppViewModel {
    private var data: BirthdayScreenData
    var onDidChangeValues: ((BirthdayScreenData) -> Void)?

    init(_ info: ChildInfo) {
        let timeSince = info.date.timeSinceNowInShifts()
        self.data = BirthdayScreenData(childImage: info.image,
                                       numberImageName: "icon\(timeSince.value)",
                                       topTitle: "TODAY \(info.name.uppercased()) IS",
                                       bottomTitle: timeSince.unit + " OLD!",
                                       type: BirthdayScreenType.allCases.randomElement() ?? .crane)
    }

    func fetchData() {
        self.onDidChangeValues?(data)
    }

    func handlePickedImage(_ image: UIImage) {
        self.data.childImage = image
        self.onDidChangeValues?(self.data)
    }
}
