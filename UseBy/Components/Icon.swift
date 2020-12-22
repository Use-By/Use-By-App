//
//  Icon.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/12/20.
//

import Foundation
import UIKit

class Icon {
    public var icon: UIImage?
    private let size: IconSize

    public enum IconSize {
        case small
        case medium
    }

    public enum IconTheme {
        case normal
        case inversed
        case action
        case secondary
        case inactive
    }

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
        }
    }
}
