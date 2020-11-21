//
//  CreateAccountViewController.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 21.10.2020.
//

import Foundation
import UIKit
import SnapKit

class CreateAccountViewController: UIViewController {
    struct CreateAccountViewUIConstants {
        static let alreadySignUpButtonMargin: CGFloat = 30
        static let mainTextMargin: CGFloat = 125
        static let createAccButtonPadding: CGFloat = 40
        static let textFieldHeight: CGFloat = 60
        static let textFieldSpacing: CGFloat = 0
        static let stackViewOfTextFields: CGFloat = 145
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
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
        configureButtons()
        configureMainText()
        configureTextFields()
    }

    func configureButtons() {
        [createAccountLabel, alreadySignUpButton, createAccountButton].forEach {
             view.addSubview($0)
        }
        // Кнопка ""Already have an account?""
        alreadySignUpButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            self.composeAlreadyButtomConstraint = make.bottom.equalTo(view)
                .offset(-CreateAccountViewUIConstants.alreadySignUpButtonMargin)
                .constraint
        }
        // Кнопка "Create Account"
        createAccountButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(-CreateAccountViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            self.composeViewBottomConstraint = make.bottom.equalTo(alreadySignUpButton)
                .offset(-CreateAccountViewUIConstants.createAccButtonPadding).constraint

        }
    }

    func configureMainText() {
        createAccountLabel.textAlignment = .center
        createAccountLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(CreateAccountViewUIConstants.mainTextMargin)
        }
    }

    func configureTextFields() {
        let arrangedSubviews = [textFieldName, textFieldEmail, textFieldPassword]
        let stackviewFields = UIStackView(arrangedSubviews: arrangedSubviews)
        stackviewFields.axis = .vertical
        stackviewFields.spacing = CreateAccountViewUIConstants.textFieldSpacing

        view.addSubview(stackviewFields)

        stackviewFields.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).offset(-CreateAccountViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            self.composeStackOfFieldBottomConstraint = make.top.equalTo(createAccountLabel)
                .offset(CreateAccountViewUIConstants.stackViewOfTextFields).constraint
        }

        arrangedSubviews.forEach {
            ($0).snp.makeConstraints { (make) -> Void in
                make.height.equalTo(CreateAccountViewUIConstants.textFieldHeight)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLayoutSubviews() {
        createAccountButton.initActionThemeStyles()
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let rectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardSize = rectangle.size
        let keyboardHeight = keyboardSize.height
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.composeViewBottomConstraint?.update(offset: -(MainButton.buttonHeight - 20))
            self.composeAlreadyButtomConstraint?.update(offset: -(keyboardHeight + 5))
            self.composeStackOfFieldBottomConstraint?.update(offset: CreateAccountViewUIConstants.stackOfFieldBottom)
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.composeViewBottomConstraint?.update(offset: -CreateAccountViewUIConstants.createAccButtonPadding)
            self.composeAlreadyButtomConstraint?.update(offset: -CreateAccountViewUIConstants.alreadySignUpButtonMargin)
            self.composeStackOfFieldBottomConstraint?.update(offset: CreateAccountViewUIConstants.stackViewOfTextFields)
            self.view.layoutIfNeeded()
        }
    }
}