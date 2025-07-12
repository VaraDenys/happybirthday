//
//  AppViewController.swift
//  HappyBirthday
//
//  Created by mac on 10.07.2025.
//

import UIKit

class AppViewController<VM: AppViewModel>: UIViewController {
    let viewModel: VM

    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
