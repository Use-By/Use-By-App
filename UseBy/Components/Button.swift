//
//  Button.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/10/20.
//

import Foundation
import UIKit
import PinLayout

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
    private var iconView: UIView?
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

    init(text: String, theme: ButtonTheme = ButtonTheme.normal, icon: UIView? = nil) {
        self.theme = theme
        super.init(frame: .zero)

        label.text = text
        label.font = Fonts.mainButtonText
        label.sizeToFit()
        label.textAlignment = .center
        layer.cornerRadius = 14

        setThemeStyles()

        if let iconView = icon {
            self.iconView = iconView
            addSubview(iconView)
        }

        addSubview(label)
    }

    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }

    private func setThemeStyles() {
        switch self.theme {
        case .normal:
            label.textColor = Colors.inversedTextColor
            backgroundColor = Colors.mainActionColor
        case .action:
            label.textColor = Colors.inversedTextColor
            let gradientLayer = Colors.mainBGGradient()
            gradientLayer.cornerRadius = 14
            self.gradientLayer = gradientLayer
            layer.insertSublayer(gradientLayer, at: 0)
        case .social:
            label.textColor = Colors.inversedTextColor
            backgroundColor = Colors.socialBGColor
        case .clear:
            label.textColor = Colors.secondaryTextColor
            label.font = Fonts.mainText
        case .pseudo:
            label.textColor = Colors.mainActionColor
            layer.borderWidth = 2
            layer.borderColor = Colors.mainActionColor.cgColor
        }
    }

    func initActionThemeStyles() {
        self.gradientLayer?.frame = bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let iconView = self.iconView {
            let spacing: CGFloat = 25
            let totalWidth = iconView.frame.width + spacing + label.frame.width

            iconView.pin.left((frame.width - totalWidth) / 2).top(24)
            label.pin.vCenter().after(of: iconView).marginLeft(spacing)
        } else {
            label.pin.vCenter().hCenter()
        }
    }
}
