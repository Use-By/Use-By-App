//
//  Router.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/8/20.
//

import Foundation
import UIKit

class Router: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        isNavigationBarHidden = true
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = Colors.defaultIconColor
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.font: Fonts.headlineText ?? UIFont()]
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: Fonts.mainText ?? UIFont()], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: Fonts.mainText ?? UIFont()], for: .highlighted)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func goToCreateAccountScreen() {
        let createAccountVC = CreateAccountViewController()
        pushViewController(createAccountVC, animated: true)
        isNavigationBarHidden = false
    }

    func goToLoginScreen() {
        let loginVC = LoginViewController()
        pushViewController(loginVC, animated: true)
        isNavigationBarHidden = false
    }

    func goToMainAuthScreen() {
        let mainAuthVC = MainAuthViewController()
        pushViewController(mainAuthVC, animated: true)
        isNavigationBarHidden = true
    }

    func goToProfileScreen() {
        let profileVC = ProfileViewController()
        pushViewController(profileVC, animated: true)
        isNavigationBarHidden = true
    }

    func goToMainScreen() {
        let mainVC = MainScreenViewController()
        pushViewController(mainVC, animated: true)
        isNavigationBarHidden = true
    }

    func showAlert(alert: UIAlertController, completion: (() -> Void)? = nil) {
        present(alert, animated: true, completion: completion)
    }
}
