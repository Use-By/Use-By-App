//
//  Button.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/10/20.
//

import Foundation
import UIKit

extension MainButton {
    public enum ButtonTheme {
        case normal
        case pseudo
        case action
        case social
        case clear
    }
}

final class MainButton: UIButton {
    private let theme: ButtonTheme
    var gradientLayer: CAGradientLayer?

    init(text: String, theme: ButtonTheme = ButtonTheme.normal) {
        self.theme = theme
        super.init(frame: .zero)
        titleLabel?.text = text
        titleLabel?.font = UIFont(name: "Lato-Black", size: 18)

        setTitle(text, for: .normal)
        layer.cornerRadius = 14
        setThemeStyles()
    }

    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }

    private func setThemeStyles() {
        switch self.theme {
        case .normal:
            setTitleColor(UIColor.inversedTextColor(), for: .normal)
            backgroundColor = UIColor.mainActionColor()
        case .action:
            setTitleColor(UIColor.inversedTextColor(), for: .normal)
            let gradientLayer = CAGradientLayer.mainBGGradient()
            gradientLayer.cornerRadius = 14
            self.gradientLayer = gradientLayer
            layer.insertSublayer(gradientLayer, at: 0)
        case .social:
            setTitleColor(UIColor.inversedTextColor(), for: .normal)
            backgroundColor = UIColor.socialBGColor()
        case .clear:
            setTitleColor(UIColor.secondaryTextColor(), for: .normal)
        case .pseudo:
            setTitleColor(UIColor.mainActionColor(), for: .normal)
            layer.borderWidth = 2
            layer.borderColor = UIColor.mainActionColor().cgColor
        }
    }

    func initActionThemeStyles() {
        guard let gradient = self.gradientLayer else {
            return
        }

        gradient.frame = bounds
    }
}
