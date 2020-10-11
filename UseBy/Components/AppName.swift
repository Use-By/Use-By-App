//
//  AppName.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit

extension AppName {
    public enum AppNameTheme {
        case normal
        case inversed
    }
}

final class AppName: UILabel {
    private let theme: AppNameTheme

    init(theme: AppNameTheme = .normal) {
        self.theme = theme
        super.init(frame: .zero)
        text = "app-name".localized.uppercased()
        font = UIFont.appNameText()

        switch self.theme {
        case .normal:
            textColor = UIColor.mainActionColor()
        case .inversed:
            textColor = UIColor.inversedTextColor()
        }

        addCharacterSpacing()
    }

    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }
}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
