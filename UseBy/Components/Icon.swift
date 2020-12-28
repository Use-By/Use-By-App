//
//  Icon.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/12/20.
//

import Foundation
import UIKit

enum IconSize {
    case small
    case medium
    case large
}

enum IconTheme {
    case normal
    case inversed
    case action
    case secondary
    case inactive
}

class Icon {
    var icon: UIImage?
    private let size: IconSize

    init(name: String, size: IconSize, theme: IconTheme = IconTheme.normal) {
        icon = UIImage(named: name)

        switch theme {
        case .normal:
            icon = icon?.withTintColor(Colors.defaultIconColor)
        case .inversed:
            icon = icon?.withTintColor(Colors.inversedIconColor)
        case .action:
            icon = icon?.withTintColor(Colors.actionIconColor)
        case .secondary:
            icon = icon?.withTintColor(Colors.secondaryIconColor)
        case .inactive:
            icon = icon?.withTintColor(Colors.inactiveIconColor)
        }

        self.size = size
    }

    func getSize() -> CGFloat {
        switch size {
        case .small:
            return 16
        case .medium:
            return 24
        case .large:
            return 36
        }
    }
}

class IconView: UIImageView {
    init(name: String, size: IconSize, theme: IconTheme = IconTheme.normal) {
        super.init(frame: .zero)
        let icon = Icon(name: name, size: size, theme: theme)

        self.image = icon.icon
        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(icon.getSize())
            make.width.equalTo(icon.getSize())
        }
        isUserInteractionEnabled = true
    }

    func setTheme(theme: IconTheme) {
        switch theme {
        case .normal:
            image = image?.withTintColor(Colors.defaultIconColor)
        case .inversed:
            image = image?.withTintColor(Colors.inversedIconColor)
        case .action:
            image = image?.withTintColor(Colors.actionIconColor)
        case .secondary:
            image = image?.withTintColor(Colors.secondaryIconColor)
        case .inactive:
            image = image?.withTintColor(Colors.inactiveIconColor)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IconButton: UIButton {
    init(name: String, size: IconSize, theme: IconTheme = IconTheme.normal) {
        super.init(frame: .zero)
        let icon = Icon(name: name, size: size, theme: theme)

        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        isUserInteractionEnabled = true

        setImage(icon.icon, for: .normal)

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(icon.getSize())
            make.width.equalTo(icon.getSize())
        }

        imageView?.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(icon.getSize())
            make.width.equalTo(icon.getSize())
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
