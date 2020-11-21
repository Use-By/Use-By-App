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
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow?
    private var router: Router?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()

        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            let mainViewController = MainAuthViewController()
            router = Router(rootViewController: mainViewController)
            window.rootViewController = router
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

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            // Обработка нажатия "Cancel"
            if (error as NSError).code == GIDSignInErrorCode.canceled.rawValue {
                return
            }

            let alert = UIAlertController(
                title: "error".localized,
                message: "google-error-description".localized,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

            router?.showAlert(alert: alert)

        return
        }
        guard let authentication = user.authentication else { return }

        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )

        Auth.auth().signIn(with: credential) { [self] (_, error) in
            if error != nil {
                let alert = UIAlertController(
                    title: "error".localized,
                    message: "google-error-description".localized,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

                router?.showAlert(alert: alert)
            }

            router?.goToProfileScreen()
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
