//
//  AppLauncher.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/21/20.
//

import Foundation
import UIKit
import GoogleSignIn

class AppLauncher: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Экран загрузки - повторяем launch screen

        if GIDSignIn.sharedInstance()?.currentUser != nil {
            if let router = navigationController as? Router {
                router.goToMainScreen()
            }
        } else {
            if let router = navigationController as? Router {
                router.goToMainAuthScreen()
            }
        }
    }
}
