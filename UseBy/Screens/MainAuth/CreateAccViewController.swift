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
    }
    private let createAccountLabel = MainText(textType: .createAccount)
    private let createAccountButton = MainButton(
        text: "create-account".localized,
        theme: .action
    )
    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: .clear
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor
        configureButtons()
        configureMainText()
    }

    func configureButtons() {
        view.addSubview(createAccountLabel)
        view.addSubview(alreadySignUpButton)
        view.addSubview(createAccountButton)
// Кнопка ""Already have an account?""
        alreadySignUpButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(CreateAccViewUIConstants.alreadySignUpButtonMargin)
            make.centerX.equalTo(view)
// Кнопка "Сreate Account"
        createAccountButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(view).offset(CreateAccViewUIConstants.createAccButtonPadding)
            make.centerX.equalTo(view)
            make.bottom.equalTo(alreadySignUpButton.snp.top).offset(CreateAccViewUIConstants.createAccButtonMargin)
            }
        }
    }

//    func configureTextFields() {
//        <#function body#>
//    }

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
}
