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

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()

        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = AppLauncher()
        window!.makeKeyAndVisible()

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
        if error != nil {
            // TODO: правильный хендл действия cancel
            let alert = UIAlertController(
                title: "error".localized,
                message: "google-error-description".localized,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

            window?.rootViewController?.present(alert, animated: true, completion: nil)

            // TODO: залогировать ошибку куда-нибудь

        return
      }
        // TODO: в rootViewController всегда хранить один view
        window?.rootViewController = MainScreenViewController()

      guard let authentication = user.authentication else { return }
        _ = GoogleAuthProvider.credential(
        withIDToken: authentication.idToken,
        accessToken: authentication.accessToken
      )
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
