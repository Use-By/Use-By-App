//
//  CreateAccViewController.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 21.10.2020.
//

import Foundation
import UIKit
import SnapKit

class Controller: UIViewController {
    struct CreateAccViewUIConstants {
        static let alreadySignUpButtonMargin: CGFloat = -30
        static let mainTextMargin: CGFloat = 125
        static let createAccButtonMargin: CGFloat = -34
        static let createAccButtonPadding: CGFloat = -40
        static let textFieldHeight: CGFloat = 60
        static let textFieldSpacing: CGFloat = 0
        static let stackViewOfTextFiels: CGFloat = 145
        static let stackOfFieldBottom: CGFloat = 50
    }

    private var composeViewBottomConstraint: Constraint?

    private var composeAlreadyButtomConstraint: Constraint?

    private var composeStackOfFieldBottomConstraint: Constraint?

    private let createAccountLabel = MainScreenTitle(labelType: .createAccount)

    private let createAccountButton = MainButton(
        text: "create-account".localized,
        theme: .action
    )

    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: .clear
    )

    private let textFieldName = TextField(purpose: .name)

    private let textFieldEmail = TextField(purpose: .email)

    private let textFieldPassword = TextField(purpose: .password)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainBGColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
            make.centerX.equalTo(view)
            self.composeAlreadyButtomConstraint = make.bottom.equalTo(view).offset(CreateAccViewUIConstants.alreadySignUpButtonMargin).constraint
        }
        // Кнопка "Сreate Account"
        createAccountButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(CreateAccViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            self.composeViewBottomConstraint = make.bottom.equalTo(alreadySignUpButton).offset(CreateAccViewUIConstants.createAccButtonPadding).constraint

        }
    }

    func configureMainText() {
        createAccountLabel.textAlignment = .center
        createAccountLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(CreateAccViewUIConstants.mainTextMargin)
        }
    }

    func configureTextFields() {
        let arrangedSubviews = [textFieldName, textFieldEmail, textFieldPassword]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackviewFields.axis = .vertical
        stackviewFields.spacing = CreateAccViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(CreateAccViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            self.composeStackOfFieldBottomConstraint = make.top.equalTo(createAccountLabel).offset(CreateAccViewUIConstants.stackViewOfTextFiels).constraint
        }

        [textFieldName, textFieldEmail, textFieldPassword] .forEach {
            ($0).snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CreateAccViewUIConstants.textFieldHeight)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        createAccountButton.initActionThemeStyles()
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.height
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.composeViewBottomConstraint?.update(offset: -(MainButton.buttonHeight - 20))
            self.composeAlreadyButtomConstraint?.update(offset: -(keyboardHight + 5))
            self.composeStackOfFieldBottomConstraint?.update(offset: CreateAccViewUIConstants.stackOfFieldBottom)
            self.view.layoutIfNeeded()
        }
       }

    @objc private func keyboardWillHide(notification: Notification) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.composeViewBottomConstraint?.update(offset: CreateAccViewUIConstants.createAccButtonPadding)
            self.composeAlreadyButtomConstraint?.update(offset: CreateAccViewUIConstants.alreadySignUpButtonMargin)
            self.composeStackOfFieldBottomConstraint?.update(offset: CreateAccViewUIConstants.stackViewOfTextFiels)
            self.view.layoutIfNeeded()
        }
      }
}
