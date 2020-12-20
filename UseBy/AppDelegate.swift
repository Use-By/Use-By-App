//
//  AppDelegate.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/4/20.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()

        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            let mainViewController = MainScreenViewController()
            window.rootViewController = Router(rootViewController: mainViewController)
            window.makeKeyAndVisible()
        }

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}
