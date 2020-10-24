//
//  MainTextLabel.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 21.10.2020.
//

import Foundation
import UIKit

final class MainScreenTitle: UILabel {
    private let screenType: ScreenType

    public enum ScreenType {
        case createAccount
        case login
    }

    init(textType: ScreenType = .createAccount) {
        self.screenType = textType
        super.init(frame: .zero)
        font = Fonts.headlineText
        textColor = Colors.mainTextColor

        switch self.screenType {
        case .createAccount:
            text = "create-account".localized
        case .login:
            text = "login".localized
        }
    }
    required init?(coder decoder: NSCoder) {
        self.screenType = .createAccount
        super.init(coder: decoder)
    }
}
