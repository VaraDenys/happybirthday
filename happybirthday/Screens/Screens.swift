//
//  Screens.swift
//  happybirthday
//
//  Created by mac on 13.07.2025.
//

struct Screens {
    static func main() -> MainViewController {
        let viewModel = MainViewModel()
        return MainViewController(viewModel: viewModel)
    }

    static func birthday(_ info: ChildInfo) -> BirthdayViewController {
        let viewModel = BirthdayViewModel(info)
        return BirthdayViewController(viewModel: viewModel)
    }
}
