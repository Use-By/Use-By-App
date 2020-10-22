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
    private let loginLabel = MainText(textType: .login)
    private let signUpButton = MainButton(
        text: "sign-up".localized,
        theme: .action
    )
    private let textFieldEmail = AuthTextField(purpose: .email)
    private let textFieldPassword = AuthTextField(purpose: .password)
    //private let line = Line(frame: CGRect(x: 0, y: 0, width: 0, height: 0), lineColor: Colors.disabledColor)

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
// Кнопка "Sign Up"
        signUpButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(LoginViewUIConstants.signUpButtonPadding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(LoginViewUIConstants.signUpButtonMargin)
        }
    }

    func configureTextFields() {
        let arrangedSubview = [textFieldEmail, textFieldPassword]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubview)
        stackviewFields.axis = .vertical
        //stackviewFields.distribution = .fill
        //stackviewFields.alignment = .center
        stackviewFields.spacing = LoginViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(LoginViewUIConstants.signUpButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
//        line.snp.makeConstraints { (make) -> Void in
//            make.width.equalTo(view).offset(LoginViewUIConstants.signUpButtonMargin)
//        }

        textFieldEmail.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewUIConstants.textFieldHeight)
        }

        textFieldPassword.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewUIConstants.textFieldHeight)
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
}
