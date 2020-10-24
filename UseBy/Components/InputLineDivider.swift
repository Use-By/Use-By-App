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

    public static func getInputDividers(count: Int) -> [InputLineDivider] {
        var inputDividers = [InputLineDivider]()

        for _ in 0..<count {
            inputDividers.append(InputLineDivider(
                frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                color: Colors.inputDividerColor
            ))
        }

        return inputDividers
    }
}
