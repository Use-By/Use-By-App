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
        static let stackViewOfTextFields: CGFloat = 145
        static let stackOfFieldBottom: CGFloat = 50
    }

    private var userAuthModel: UserAuthModelProtocol?
    private var composeStackOfFieldBottomConstraint: Constraint?

    private var composeViewBottomConstraint: Constraint?
    private let loginLabel = MainScreenTitle(labelType: .login)
    private let signInButton = MainButton(
        text: "sign-in".localized,
        theme: .action
    )
    private var topConstraint: Constraint?
    private let inputFieldEmail = TextField(purpose: .email)
    private let inputFieldPassword = TextField(purpose: .password)

    override func viewDidLoad() {
        super.viewDidLoad()
        userAuthModel = UserAuthModel()
        view.backgroundColor = Colors.mainBGColor
        configureButtons()
        configureMainText()
        configureTextFields()

        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )

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
        signInButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        signInButton.isEnabled = false
    }

    func configureTextFields() {
        let arrangedSubviews = [inputFieldEmail, inputFieldPassword]
        let stackViewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackViewFields.axis = .vertical
        stackViewFields.spacing = LoginViewUIConstants.textFieldSpacing

        view.addSubview(stackViewFields)

        stackViewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(-LoginViewUIConstants.signInButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            self.composeStackOfFieldBottomConstraint = make.top.equalTo(loginLabel)
                .offset(LoginViewUIConstants.stackViewOfTextFields).constraint
        }

        inputFieldEmail.textField.delegate = self
        inputFieldPassword.textField.delegate = self
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

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.height
        self.composeViewBottomConstraint?.update(offset: -(keyboardHight + 10))
        self.composeStackOfFieldBottomConstraint?.update(offset: LoginViewUIConstants.stackOfFieldBottom)
        self.view.layoutIfNeeded()
        view.layoutIfNeeded()
       }

    @objc private func keyboardWillHide(notification: Notification) {
            self.composeViewBottomConstraint?.update(offset: -LoginViewUIConstants.signInButtonMargin)
        self.composeStackOfFieldBottomConstraint?.update(offset: LoginViewUIConstants.stackViewOfTextFields)
            self.view.layoutIfNeeded()
      }

    @objc
    private func didTapLogInButton() {

        let validationErrors = validateTextFields(fields: [inputFieldEmail, inputFieldPassword])

        if validationErrors.count != 0 {
            let errorsText = getErrorsTexts(validationErrors: validationErrors)

            let alert = UIAlertController(
                title: "error".localized,
                message: errorsText,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)

            return
        }

        guard let email = inputFieldEmail.textField.text,
              let password = inputFieldPassword.textField.text else {
            return
        }

        if userAuthModel != nil {
            userAuthModel!.login(email: email, password: password, completion: ({ [weak self] error in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if let error = error {
                        // Показываем алерт ошибки
                        _ = Alert(
                            title: "error".localized,
                            message: getUserAuthErrorText(error: error),
                            action: .non
                        )

                        return
                    }

                    if let router = self.navigationController as? Router {
                        router.goToMainScreen()
                    }
                }
            })
        )}
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        checkForEnablingMainActionButton()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        checkForEnablingMainActionButton()
        return true
    }

    private func checkForEnablingMainActionButton() {
        if inputFieldEmail.isEmpty() || inputFieldPassword.isEmpty() {
            signInButton.isEnabled = false
            return
        }

        signInButton.isEnabled = true
    }
}
