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
    var composeViewBottomConstraint: Constraint?
    private let loginLabel = MainScreenTitle(textType: .login)
    private let signUpButton = MainButton(
        text: "sign-up".localized,
        theme: .action
    )
    var topConstraint: Constraint?
    private let textFieldEmail = AuthTextField(purpose: .email)
    private let textFieldPassword = AuthTextField(purpose: .password)

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
            self.composeViewBottomConstraint = make.bottom.equalTo(view).offset(LoginViewUIConstants.signUpButtonMargin).constraint
        }
        view.snp.makeConstraints { (make) -> Void in
            self.topConstraint = make.top.equalTo(view).constraint
            make.left.equalTo(view)
        }
    }

    func configureTextFields() {
        let arrangedSubview = [textFieldEmail, textFieldPassword]
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

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.height
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.composeViewBottomConstraint?.update(offset: -(keyboardHight + 10))
            self.view.layoutIfNeeded()
        }
       }

    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.height
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.composeViewBottomConstraint?.update(offset: LoginViewUIConstants.signUpButtonMargin)
            self.view.layoutIfNeeded()
        }
      }

}
