//
//  LoginViewController.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 22.10.2020.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    struct LoginViewUIConstants {
        static let backgroundColor = Colors.mainBGColor
        static let mainTextMargin: CGFloat = 190
        static let signInButtonMargin: CGFloat = -120
        static let signInButtonPadding: CGFloat = -40
        static let textFieldSpacing: CGFloat = 0
    }
    private let loginLabel = MainScreenTitle(textType: .login)
    private let signInButton = MainButton(
        text: "sign-in".localized,
        theme: .action
    )
    private let textFieldEmail = AuthTextField(purpose: .email)
    private let textFieldPassword = AuthTextField(purpose: .password)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainBGColor
        configureButtons()
        configureMainText()
        configureTextFields()
    }

    func configureButtons() {
        view.addSubview(loginLabel)
        view.addSubview(signInButton)
        // Кнопка "Sign In"
        signInButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(LoginViewUIConstants.signInButtonPadding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(LoginViewUIConstants.signInButtonMargin)
        }

        signInButton.isEnabled = false
    }

    func configureTextFields() {
        let arrangedSubviews = [textFieldEmail, textFieldPassword]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackviewFields.axis = .vertical
        stackviewFields.spacing = LoginViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(LoginViewUIConstants.signInButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }

        textFieldEmail.field.addTarget(self, action: #selector(checkForEnablingMainActionButton), for: .editingChanged)
        textFieldPassword.field.addTarget(self, action: #selector(checkForEnablingMainActionButton), for: .editingChanged)
    }

    func configureMainText() {
        loginLabel.textAlignment = .center
        loginLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(LoginViewUIConstants.mainTextMargin)
        }
    }

    override func viewDidLayoutSubviews() {
        signInButton.initActionThemeStyles()
    }

    @objc
    private func checkForEnablingMainActionButton() {
        if textFieldEmail.isEmpty() || textFieldPassword.isEmpty() {
            return
        }

        signInButton.isEnabled = true
    }
}
