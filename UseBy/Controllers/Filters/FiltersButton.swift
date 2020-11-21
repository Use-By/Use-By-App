//
//  FiltersButton.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/21/20.
//

import Foundation
import UIKit

class FilterButton: UIButton {
    struct UIConstants {
        static let height: CGFloat = 40
        static let cornerRadius: CGFloat = 14
        static let iconMargin: CGFloat = 5
    }

    init(text: String, icon: Icon? = nil) {
        super.init(frame: .zero)

        adjustsImageWhenHighlighted = false
        titleLabel?.text = text
        setTitle(self.titleLabel?.text, for: .normal)
        titleLabel?.font = Fonts.mainText
        titleLabel?.textAlignment = .center
        layer.cornerRadius = UIConstants.cornerRadius

        backgroundColor = Colors.filterControlBackground
        setTitleColor(Colors.filterHighlightColor, for: .normal)
        setTitleColor(Colors.inversedTextColor, for: .highlighted)

        if let icon = icon {
            setImage(icon.icon, for: .normal)
            imageEdgeInsets.right = UIConstants.iconMargin
        }
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: [.beginFromCurrentState, .transitionCrossDissolve, .curveEaseInOut],
                animations: {
                    self.backgroundColor = self.isHighlighted
                        ? Colors.filterHighlightColor
                        : Colors.filterControlBackground
                    self.imageView?.tintColor = Colors.inversedIconColor
                }, completion: nil)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
