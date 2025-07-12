//
//  AppDelegate.swift
//  happybirthday
//
//  Created by mac on 12.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainView = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainView)

        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
}

