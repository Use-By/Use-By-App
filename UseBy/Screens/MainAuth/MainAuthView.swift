//
//  MainAuthView.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class MainAuthView: UIView {
    private let rootFlexContainer = UIView()

    private let appNameLabel = AppName()
    private let appDescriptionLabel = UILabel()
    private let googleSignUpButton: MainButton
    private let signUpButton = MainButton(text: "create-account".localized, theme: MainButton.ButtonTheme.action)
    private let alreadySignUpButton = MainButton(
        text: "already-have-account".localized,
        theme: MainButton.ButtonTheme.clear
    )
    private let backgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 500, height: 500),
        circleColor: Colors.mainActionBGColor
    )
    private let bottomBackgroundCircle = BackgroundCircle(
        frame: CGRect(x: 0, y: 0, width: 600, height: 600),
        circleColor: Colors.secondaryActionBGColor
    )

    init() {
        let googleIcon = Icon.getIcon(name: "Google", size: .small, color: Colors.inversedTextColor)
        googleSignUpButton = MainButton(
            text: "create-account-google".localized,
            theme: MainButton.ButtonTheme.social,
            icon: googleIcon
        )
        super.init(frame: .zero)

        backgroundColor = Colors.mainBGColor

        initAppDescriptionLabel()

        rootFlexContainer
            .flex
            .paddingHorizontal(15)
            .direction(.column)
            .alignItems(.center)
            .marginTop(50%)
            .justifyContent(.center)
            .define { flex in
                flex.addItem(appNameLabel).marginBottom(15)
                flex.addItem(appDescriptionLabel).marginBottom(25)
                flex.addItem(googleSignUpButton).width(100%).padding(15).marginBottom(20)
                flex.addItem(signUpButton).width(100%).padding(15).marginBottom(20)
            }

        addSubview(alreadySignUpButton)
        addSubview(backgroundCircle)
        addSubview(bottomBackgroundCircle)
        addSubview(rootFlexContainer)
    }

    required init?(coder: NSCoder) {
        googleSignUpButton = MainButton(text: "create-account-google".localized, theme: MainButton.ButtonTheme.social)
        super.init(coder: coder)
    }

    func initAppDescriptionLabel() {
        appDescriptionLabel.text = "app-description".localized
        appDescriptionLabel.font = Fonts.mainText
        appDescriptionLabel.textColor = Colors.mainTextColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundCircle.pin.center().sizeToFit()
        bottomBackgroundCircle.pin.bottom(-200).hCenter()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)

        alreadySignUpButton.pin.bottom(pin.safeArea.bottom + 5).hCenter().width(100%).height(55)

        self.signUpButton.initActionThemeStyles()
    }
}
