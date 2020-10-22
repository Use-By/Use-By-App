//
//  Line.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 22.10.2020.
//

import Foundation
import UIKit

class Line: UIView {
    private var color: UIColor
    init(frame: CGRect, lineColor: UIColor) {
        self.color = lineColor
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: frame.size.width/2, y: frame.size.height/2))
        aPath.addLine(to: CGPoint(x: frame.size.width/2, y: frame.size.height/2))

        //Keep using the method addLineToPoint until you get to the one where about to close the path

//        aPath.close()
//
//        //If you want to stroke it with a red color
//        UIColor.red.set()
//        aPath.stroke()
//        //If you want to fill it as well
//        aPath.fill()
    }
}
