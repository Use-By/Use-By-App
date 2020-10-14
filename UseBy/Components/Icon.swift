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

    init(name: String, size: IconSize) {
        icon = UIImage(named: name)
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
