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

    enum ScreenType {
        case createAccount
        case login
        case filterBy
        case profile
    }

    init(labelType: ScreenType = .createAccount) {
        screenType = labelType
        super.init(frame: .zero)
        font = Fonts.headlineText
        textColor = Colors.mainTextColor

        switch screenType {
        case .createAccount:
            text = "create-account".localized
        case .login:
            text = "login".localized
        case .filterBy:
            text = "filter-by".localized
        case .profile:
            text = "profile".localized
        }
    }
    required init?(coder decoder: NSCoder) {
        screenType = .createAccount
        super.init(coder: decoder)
    }
}
