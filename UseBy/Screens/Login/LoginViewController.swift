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
        static let mainTextMargin: CGFloat = 190
        static let signInButtonMargin: CGFloat = 120
        static let signInButtonPadding: CGFloat = 40
        static let textFieldHeight: CGFloat = 60
        static let textFieldSpacing: CGFloat = 0
    }

    private var composeViewBottomConstraint: Constraint?
    private let loginLabel = MainScreenTitle(labelType: .login)
    private let signInButton = MainButton(
        text: "sign-in".localized,
        theme: .action
    )
    private var topConstraint: Constraint?
    private let textFieldEmail = TextField(purpose: .email)
    private let textFieldPassword = TextField(purpose: .password)

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
        view.backgroundColor = Colors.mainBGColor
        configureButtons()
        configureMainText()
        configureTextFields()
    }

    func configureButtons() {
        [loginLabel, signInButton].forEach {
            view.addSubview($0)
        }

        // Кнопка "Sign In"
        signInButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(-LoginViewUIConstants.signInButtonPadding)
            make.centerX.equalTo(view)
            self.composeViewBottomConstraint = make.bottom.equalTo(view)
                .offset(-LoginViewUIConstants.signInButtonMargin).constraint
        }
        view.snp.makeConstraints { (make) -> Void in
            self.topConstraint = make.top.equalTo(view).constraint
            make.left.equalTo(view)
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
            make.width.equalTo(view).offset(-LoginViewUIConstants.signInButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        arrangedSubviews.forEach {
            ($0).snp.makeConstraints { (make) -> Void in
                make.height.equalTo(LoginViewUIConstants.textFieldHeight)
            }
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

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLayoutSubviews() {
        signInButton.initActionThemeStyles()
    }

    @objc
    private func checkForEnablingMainActionButton() {
        if textFieldEmail.isEmpty() || textFieldPassword.isEmpty() {
            signInButton.isEnabled = false
            return
        }

        signInButton.isEnabled = true
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.height
        self.composeViewBottomConstraint?.update(offset: -(keyboardHight + 10))
        self.view.layoutIfNeeded()
        view.layoutIfNeeded()
       }

    @objc private func keyboardWillHide(notification: Notification) {
            self.composeViewBottomConstraint?.update(offset: -LoginViewUIConstants.signUpButtonMargin)
            self.view.layoutIfNeeded()
      }

}
