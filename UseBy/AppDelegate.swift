//
//  AppDelegate.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/4/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            let mainViewController = MainAuthViewController()
            let navigationController = UINavigationController(rootViewController: mainViewController)
            configureNavigationController(navigationController: navigationController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }

        return true
    }

    func configureNavigationController(navigationController: UINavigationController) {
        navigationController.isNavigationBarHidden = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = Colors.defaultIconColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: Fonts.headlineText]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Fonts.mainText], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Fonts.mainText], for: .highlighted)
    }
}
