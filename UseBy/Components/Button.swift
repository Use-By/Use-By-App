//
//  Button.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/10/20.
//

import Foundation
import UIKit

final class MainButton: UIButton {
    struct MainButtonUIConstants {
        static let iconMargin: CGFloat = 10
        static let cornerRadius: CGFloat = 14
    }

    public enum ButtonTheme {
        case normal
        case pseudo
        case action
        case social
        case clear
    }

    static let buttonHeight = 60
    private let theme: ButtonTheme
    private var label = UILabel()
    var gradientLayer: CAGradientLayer?

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: [.beginFromCurrentState, .transitionCrossDissolve, .curveEaseInOut],
                animations: {
                    self.alpha = self.isHighlighted ? 0.7 : 1
                }, completion: nil)
        }
    }

    override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                backgroundColor = Colors.disabledBGColor
                if self.gradientLayer != nil {
                    layer.sublayers?.remove(at: 0)
                    gradientLayer = nil
                }
            } else {
                setThemeStyles()
            }
        }
    }

    init(text: String, theme: ButtonTheme = ButtonTheme.normal, icon: Icon? = nil) {
        self.theme = theme
        super.init(frame: .zero)

        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        titleLabel?.text = text
        setTitle(self.titleLabel?.text, for: .normal)
        titleLabel?.font = Fonts.mainButtonText
        titleLabel?.textAlignment = .center
        layer.cornerRadius = MainButtonUIConstants.cornerRadius
        setTitleColor(Colors.inversedTextColor, for: .disabled)

        setThemeStyles()

        if let icon = icon {
            setImage(icon.icon, for: .normal)
            imageEdgeInsets.right = MainButtonUIConstants.iconMargin
        }
    }

    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }

    private func setThemeStyles() {
        switch self.theme {
        case .normal:
            titleLabel?.textColor = Colors.inversedTextColor
            backgroundColor = Colors.mainActionColor
            setTitleColor(Colors.inversedTextColor, for: .normal)
        case .action:
            titleLabel?.textColor = Colors.inversedTextColor
            setTitleColor(Colors.inversedTextColor, for: .normal)

            if self.gradientLayer == nil {
                let gradientLayer = Colors.mainBGGradient()
                gradientLayer.cornerRadius = MainButtonUIConstants.cornerRadius
                self.gradientLayer = gradientLayer
                layer.insertSublayer(gradientLayer, at: 0)
            }
        case .social:
            titleLabel?.textColor = Colors.inversedTextColor
            setTitleColor(Colors.inversedTextColor, for: .normal)
            backgroundColor = Colors.socialBGColor
        case .clear:
            titleLabel?.textColor = Colors.secondaryTextColor
            setTitleColor(Colors.secondaryTextColor, for: .normal)
            titleLabel?.font = Fonts.mainText
        case .pseudo:
            titleLabel?.textColor = Colors.mainActionColor
            setTitleColor(Colors.mainActionColor, for: .normal)
            layer.borderWidth = 2
            layer.borderColor = Colors.mainActionColor.cgColor
        }
    }

    func initActionThemeStyles() {
        self.gradientLayer?.frame = bounds
    }
}
