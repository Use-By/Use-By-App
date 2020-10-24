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
        static let textFieldHeight: CGFloat = 60
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
    }

    func configureTextFields() {
        let inputDividers = InputLineDivider.getInputDividers(count: 3)
        let arrangedSubview = [textFieldName,
                               inputDividers[0],
                               textFieldEmail,
                               inputDividers[1],
                               textFieldPassword,
                               inputDividers[2]]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubview)
        stackviewFields.axis = .vertical
        stackviewFields.spacing = CreateAccViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(CreateAccViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        textFieldName.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CreateAccViewUIConstants.textFieldHeight)
        }

        textFieldEmail.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CreateAccViewUIConstants.textFieldHeight)
        }

        textFieldPassword.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CreateAccViewUIConstants.textFieldHeight)
        }

        inputDividers.forEach { inputDivider in
            inputDivider.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(InputLineDivider.dividerHeight)
            }
        }
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
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}
