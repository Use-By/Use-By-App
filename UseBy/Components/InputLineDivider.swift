//
//  BackgroundCircle.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit

class InputLineDivider: UIView {
    public static let dividerHeight = 1

    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
