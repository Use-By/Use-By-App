//
//  CreateAccViewController.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 21.10.2020.
//
import Foundation
import UIKit
import SnapKit

class CreateAccViewController: UIViewController {
    struct CreateAccViewUIConstants {
        static let backgroundColor = Colors.mainBGColor
        static let alreadySignUpButtonMargin: CGFloat = -50
        static let mainTextMargin: CGFloat = 190
        static let createAccButtonMargin: CGFloat = -34
        static let createAccButtonPadding: CGFloat = -40
        static let textFieldHeight: CGFloat = 61
        static let textFieldSpacing: CGFloat = 0
    }
    private let createAccountLabel = MainScreenTitle(textType: .createAccount)
    private let createAccountButton = MainButton(
        text: "create-account".localized,
        theme: .action
    )
    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: .clear
    )
    private let textFieldName = AuthTextField(purpose: .name)
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
        view.addSubview(createAccountLabel)
        view.addSubview(alreadySignUpButton)
        view.addSubview(createAccountButton)

        // Кнопка ""Already have an account?""
        alreadySignUpButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(CreateAccViewUIConstants.alreadySignUpButtonMargin)
            make.centerX.equalTo(view)
        }
        alreadySignUpButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        // Кнопка "Сreate Account"
        createAccountButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(CreateAccViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(alreadySignUpButton.snp.top).offset(CreateAccViewUIConstants.createAccButtonMargin)
        }
        createAccountButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        createAccountButton.isEnabled = false
    }

    func configureTextFields() {
        let arrangedSubviews = [textFieldName,
                               textFieldEmail,
                               textFieldPassword]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackviewFields.axis = .vertical
        stackviewFields.spacing = CreateAccViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(CreateAccViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }

        textFieldName.field.addTarget(self, action: #selector(checkForEnablingMainActionButton), for: .editingChanged)
        textFieldEmail.field.addTarget(self, action: #selector(checkForEnablingMainActionButton), for: .editingChanged)
        textFieldPassword.field.addTarget(self, action: #selector(checkForEnablingMainActionButton), for: .editingChanged)
    }

    func configureMainText() {
        createAccountLabel.textAlignment = .center
        createAccountLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(CreateAccViewUIConstants.mainTextMargin)
        }
    }

    override func viewDidLayoutSubviews() {
        createAccountButton.initActionThemeStyles()
    }

    @objc
    private func didTapLoginButton() {
        if let router = navigationController as? Router {
            router.goToLoginScreen()
        }
    }

    @objc
    private func didTapSignUpButton() {
        let validationErrors = validateTextFields(fields: [textFieldName, textFieldEmail, textFieldPassword])

        if validationErrors.count != 0 {
            let errorsText = getErrorsTexts(validationErrors: validationErrors)

            let alert = UIAlertController(
                title: "error".localized,
                message: errorsText,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
        }
    }

    @objc
    private func checkForEnablingMainActionButton() {
        if textFieldName.isEmpty() || textFieldEmail.isEmpty() || textFieldPassword.isEmpty() {
            createAccountButton.isEnabled = false
            return
        }

        createAccountButton.isEnabled = true
    }
}
