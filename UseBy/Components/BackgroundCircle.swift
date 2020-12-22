//
//  BackgroundCircle.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation
import UIKit

class BackgroundCircle: UIView {
    private var color: UIColor

    init(frame: CGRect, circleColor: UIColor) {
        self.color = circleColor
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        self.color = .white
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(self.color.cgColor)

            let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            let radius = (frame.size.width - 10)/2
            context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)

            context.fillPath()
        }
    }
}
