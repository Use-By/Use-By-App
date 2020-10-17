//
//  MainAuthViewController.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit
import SnapKit

struct MainAuthViewUIConstants {
    static let backgroundCircleWidth = 500
    static let bottomCircleWidth = 600
    static let buttonsSpacing: CGFloat = 15
    static let signupButtonMargin: CGFloat = 45
    static let stackViewMargin: CGFloat = -100
    static let stackViewPadding: CGFloat = 20
    static let alreadySignUpButtonMargin: CGFloat = -50
}

class MainAuthViewController: UIViewController {
    private let appNameLabel = AppName()
    private let appDescriptionLabel = UILabel()
    private let googleSignUpButton = MainButton(
        text: "create-account-google".localized,
        theme: .social,
        icon: Icon(name: "Google", size: .small, theme: .inversed)
    )
    private let signUpButton = MainButton(text: "create-account".localized, theme: .action)
    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: .clear
    )
    private let backgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        circleColor: Colors.mainActionBGColor
    )
    private let bottomBackgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        circleColor: Colors.secondaryActionBGColor
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.mainBGColor
        view.addSubview(backgroundCircle)
        view.addSubview(bottomBackgroundCircle)
        alignBottomCircles()
        initAppDescriptionLabel()

        let arrangedSubviews = [appNameLabel, appDescriptionLabel, googleSignUpButton]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = MainAuthViewUIConstants.buttonsSpacing
        appNameLabel.textAlignment = .center
        view.addSubview(stackView)
        view.addSubview(signUpButton)

        signUpButton.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
            make.width.equalTo(stackView)
            make.centerX.equalTo(stackView)
            make.centerY.equalTo(stackView.snp.bottom).offset(MainAuthViewUIConstants.signupButtonMargin)
        }
        googleSignUpButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(MainButton.buttonHeight)
        }
        stackView.snp.makeConstraints {(make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(MainAuthViewUIConstants.stackViewMargin)
            make.width.equalTo(view).inset(
                UIEdgeInsets(
                    top: 0,
                    left: MainAuthViewUIConstants.stackViewPadding,
                    bottom: 0,
                    right: MainAuthViewUIConstants.stackViewPadding
                )
            )
        }

        view.addSubview(alreadySignUpButton)
        alreadySignUpButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(MainAuthViewUIConstants.alreadySignUpButtonMargin)
            make.centerX.equalTo(view)
        }
    }

    func alignBottomCircles() {
        backgroundCircle.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.height.equalTo(MainAuthViewUIConstants.backgroundCircleWidth)
            make.width.equalTo(MainAuthViewUIConstants.backgroundCircleWidth)
        }
        bottomBackgroundCircle.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view.snp.bottom)
            make.centerX.equalTo(view)
            make.height.equalTo(MainAuthViewUIConstants.bottomCircleWidth)
            make.width.equalTo(MainAuthViewUIConstants.bottomCircleWidth)
        }
    }

    func initAppDescriptionLabel() {
        appDescriptionLabel.text = "app-description".localized
        appDescriptionLabel.font = Fonts.mainText
        appDescriptionLabel.textColor = Colors.mainTextColor
        appDescriptionLabel.textAlignment = .center
    }

    override func viewDidLayoutSubviews() {
        signUpButton.initActionThemeStyles()
    }
}
