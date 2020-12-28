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
        static let loaderHeight: CGFloat = 20
        static let loaderMargin: CGFloat = 10
        static let loaderLineWidth: CGFloat = 3
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
    private let loader: Loader = {
        let loader = Loader(
            lineWidth: MainButtonUIConstants.loaderLineWidth, colors: [Colors.mainBGColor]
        )
        loader.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()
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

    var isLoading: Bool = false {
        didSet {
            if isLoading {
                loader.isHidden = false
                loader.isAnimating = true
            } else {
                loader.isHidden = true
                loader.isAnimating = false
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

        configureLoader()
    }

    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }

    func configureLoader() {
        addSubview(loader)
        loader.isAnimating = true
        loader.isHidden = true

        guard let titleLabel = titleLabel else {
            return
        }

        loader.snp.makeConstraints {(make) in
            make.left.equalTo(titleLabel.snp.right).offset(MainButtonUIConstants.loaderMargin)
            make.width.equalTo(MainButtonUIConstants.loaderHeight)
            make.height.equalTo(MainButtonUIConstants.loaderHeight)
            make.centerY.equalTo(self)
        }
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
