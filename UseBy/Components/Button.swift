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

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .transitionCrossDissolve, .curveEaseInOut], animations: {
                self.alpha = self.isHighlighted ? 0.7 : 1
            }, completion: nil)
        }
    }

    init(text: String, theme: ButtonTheme = ButtonTheme.normal) {
        self.theme = theme
        super.init(frame: .zero)
        titleLabel?.text = text
        titleLabel?.font = UIFont.mainButtonText()

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
            titleLabel?.font = UIFont.mainText()
        case .pseudo:
            setTitleColor(UIColor.mainActionColor(), for: .normal)
            layer.borderWidth = 2
            layer.borderColor = UIColor.mainActionColor().cgColor
        }
    }

    func initActionThemeStyles() {
        self.gradientLayer?.frame = bounds
    }
}
