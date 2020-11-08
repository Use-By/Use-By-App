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
            let router = Router(rootViewController: mainViewController)
            window.rootViewController = router
            window.makeKeyAndVisible()
        }

        return true
    }
}
