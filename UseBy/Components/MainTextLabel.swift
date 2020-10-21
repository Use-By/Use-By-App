//
//  MainTextLabel.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 21.10.2020.
//

import Foundation
import UIKit

final class MainText: UILabel {
    private let textType: TextType

    public enum TextType {
        case createAccount
        case login
    }

    init(textType: TextType = .createAccount) {
        self.textType = textType
        super.init(frame: .zero)
        font = Fonts.headlineText
        textColor = Colors.mainTextColor

        switch self.textType {
        case .createAccount:
            text = "create-account".localized
        case .login:
            text = "login".localized
        }
    }
    required init?(coder decoder: NSCoder) {
        self.textType = .createAccount
        super.init(coder: decoder)
    }
}
