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
        static let signUpButtonMargin: CGFloat = -120
        static let signUpButtonPadding: CGFloat = -40
        static let textFieldHeight: CGFloat = 60
        static let textFieldSpacing: CGFloat = 0
    }
    private let loginLabel = MainScreenTitle(textType: .login)
    private let signUpButton = MainButton(
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
        view.addSubview(signUpButton)
        // Кнопка "Sign In"
        signUpButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(LoginViewUIConstants.signUpButtonPadding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(LoginViewUIConstants.signUpButtonMargin)
        }

        signUpButton.isEnabled = false
    }

    func configureTextFields() {
        let inputDividers = InputLineDivider.getInputDividers(count: 2)
        let arrangedSubview = [textFieldEmail, inputDividers[0], textFieldPassword, inputDividers[1]]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubview)
        stackviewFields.axis = .vertical
        stackviewFields.spacing = LoginViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(LoginViewUIConstants.signUpButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }

        textFieldEmail.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewUIConstants.textFieldHeight)
        }

        textFieldPassword.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewUIConstants.textFieldHeight)
        }

        inputDividers.forEach { inputDivider in
            inputDivider.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(InputLineDivider.dividerHeight)
            }
        }
    }

    func configureMainText() {
        loginLabel.textAlignment = .center
        loginLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(LoginViewUIConstants.mainTextMargin)
        }
    }

    override func viewDidLayoutSubviews() {
        signUpButton.initActionThemeStyles()
    }

    @objc
    private func checkForEnablingMainActionButton() {
        if textFieldEmail.isEmpty() || textFieldPassword.isEmpty() {
            return
        }

        signUpButton.isEnabled = true
    }
}
