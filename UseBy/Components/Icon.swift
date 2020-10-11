//
//  Icon.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/12/20.
//

import Foundation
import UIKit
import SwiftSVG

class Icon {
    public enum IconSize {
        case small
        case medium
    }

    class func getIcon(name: String, size: IconSize, color: UIColor?) -> UIView {
        let iconSize = self.getSize(size: size)
        let svgIcon = UIView(SVGNamed: name) { (layer: SVGLayer) in
            layer.fillColor = color?.cgColor ?? UIColor.mainActionColor().cgColor
            layer.resizeToFit(CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
        }

        return svgIcon
    }

    class func getSize(size: IconSize) -> CGFloat {
        switch size {
        case .small:
            return 16
        case .medium:
            return 24
        }
    }
}
