//
//  AppName.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit

final class AppName: UILabel {
    private let theme: AppNameTheme

    public enum AppNameTheme {
        case normal
        case inversed
    }

    init(theme: AppNameTheme = .normal) {
        self.theme = theme
        super.init(frame: .zero)
        text = "app-name".localized.uppercased()
        font = Fonts.appNameText

        switch self.theme {
        case .normal:
            textColor = Colors.mainActionColor
        case .inversed:
            textColor = Colors.inversedTextColor
        }

        addCharacterSpacing(kernValue: 5)
    }

    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }
}
