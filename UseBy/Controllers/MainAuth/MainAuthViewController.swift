//
//  MainAuthViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import GoogleSignIn

class MainAuthViewController: UIViewController {
    struct MainAuthViewUIConstants {
        static let backgroundCircleWidth = 500
        static let bottomCircleWidth = 600
        static let buttonsSpacing: CGFloat = 15
        static let signupButtonMargin: CGFloat = 45
        static let stackViewMargin: CGFloat = -100
        static let stackViewPadding: CGFloat = 20
        static let alreadySignUpButtonMargin: CGFloat = -50
    }

    private let appNameLabel = AppName()
    private let appDescriptionLabel = UILabel()
    private let googleSignInButton = GoogleSignInButton()
    private let signUpButton = MainButton(text: "create-account".localized, theme: .action)
    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: .clear
    )
    private let backgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        circleColor: Colors.mainActionBGColor
    )
    private let bottomBackgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        circleColor: Colors.secondaryActionBGColor
    )
    private var userAuthModel: UserAuthModel?

    init(userAuthModel: UserAuthModel) {
        super.init(nibName: nil, bundle: nil)
        self.userAuthModel = userAuthModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        view.backgroundColor = Colors.mainBGColor
        configureBottomCircles()
        configureAppDescriptionLabel()
        configureAuthButtons()
    }

    func configureAuthButtons() {
        guard let googleButton = googleSignInButton.view else {
            return
        }
        let arrangedSubviews = [appNameLabel, appDescriptionLabel, googleButton]
        googleSignInButton.didMove(toParent: self)
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = MainAuthViewUIConstants.buttonsSpacing
        appNameLabel.textAlignment = .center
        view.addSubview(stackView)
        view.addSubview(signUpButton)

        signUpButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(stackView)
            make.centerX.equalTo(stackView)
            make.centerY.equalTo(stackView.snp.bottom).offset(MainAuthViewUIConstants.signupButtonMargin)
        }
        googleButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
        }
        stackView.snp.makeConstraints {(make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(MainAuthViewUIConstants.stackViewMargin)
            make.width.equalTo(view).inset(
                UIEdgeInsets(
                    top: 0,
                    left: MainAuthViewUIConstants.stackViewPadding,
                    bottom: 0,
                    right: MainAuthViewUIConstants.stackViewPadding
                )
            )
        }

        view.addSubview(alreadySignUpButton)
        alreadySignUpButton.snp.makeConstraints {(make) -> Void in
            make.bottom.equalTo(view).offset(MainAuthViewUIConstants.alreadySignUpButtonMargin)
            make.centerX.equalTo(view)
        }

        alreadySignUpButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }

    func configureBottomCircles() {
        view.addSubview(backgroundCircle)
        view.addSubview(bottomBackgroundCircle)
        backgroundCircle.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.height.equalTo(MainAuthViewUIConstants.backgroundCircleWidth)
            make.width.equalTo(MainAuthViewUIConstants.backgroundCircleWidth)
        }
        bottomBackgroundCircle.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view.snp.bottom)
            make.centerX.equalTo(view)
            make.height.equalTo(MainAuthViewUIConstants.bottomCircleWidth)
            make.width.equalTo(MainAuthViewUIConstants.bottomCircleWidth)
        }
    }

    func configureAppDescriptionLabel() {
        appDescriptionLabel.text = "app-description".localized
        appDescriptionLabel.font = Fonts.mainText
        appDescriptionLabel.textColor = Colors.mainTextColor
        appDescriptionLabel.textAlignment = .center
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        signUpButton.initActionThemeStyles()
    }

    @objc
    private func didTapCreateAccount() {
        if let router = navigationController as? Router {
            router.goToCreateAccountScreen()
        }
    }

    @objc
    private func didTapLoginButton() {
        if let router = navigationController as? Router {
            router.goToLoginScreen()
        }
    }
}

extension MainAuthViewController: GIDSignInDelegate {
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

            if let router = navigationController as? Router {
                router.showAlert(alert: alert)
            }

            return
        }

        guard let authentication = user.authentication else { return }

        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )

        userAuthModel?.loginWithCredential(credential: credential, completion: { (error) in
            if let error = error {
                let alert = UIAlertController(
                    title: "error".localized,
                    message: getUserAuthErrorText(error: error),
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

                if let router = self.navigationController as? Router {
                    router.showAlert(alert: alert)
                }

                return
            }

            if let router = self.navigationController as? Router {
                router.goToMainScreen()
            }
        })
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
