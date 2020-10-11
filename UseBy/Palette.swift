//
//  Palette.swift
//  Файл со всеми цветами приложения
//
//  Created by Nadezda Svoykina on 10/10/20.
//

import Foundation
import UIKit

extension UIColor {
    class func mainTextColor() -> UIColor {
        return .black
    }

    class func inversedTextColor() -> UIColor {
        return .white
    }

    class func secondaryTextColor() -> UIColor {
        return UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
    }

    class func mainBGColor() -> UIColor {
        return .white
    }

    class func mainActionBGColor() -> UIColor {
        return UIColor(red: 254/255, green: 169/255, blue: 155/255, alpha: 0.1)
    }

    class func socialBGColor() -> UIColor {
        return UIColor(red: 66/255, green: 103/255, blue: 177/255, alpha: 1.0)
    }

    class func secondaryActionBGColor() -> UIColor {
        return UIColor(red: 64/255, green: 188/255, blue: 216/255, alpha: 0.1)
    }

    class func mainActionColor() -> UIColor {
        return UIColor(red: 255/255, green: 97/255, blue: 128/255, alpha: 1.0)
    }

    class func secondaryActionColor() -> UIColor {
        return UIColor(red: 254/255, green: 169/255, blue: 155/255, alpha: 1.0)
    }

    class func disabledBGColor() -> UIColor {
        return UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
    }
}

extension CAGradientLayer {
    class func mainBGGradient() -> CAGradientLayer {
        let topColor = UIColor.mainActionColor()
        let bottomColor = UIColor.secondaryActionColor()

        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [NSNumber(0.0), NSNumber(1.0)]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations

        return gradientLayer
    }
}

extension UIFont {
    // Основной текст
    class func mainText() -> UIFont? {
        let font = UIFont(name: "Lato-Regular", size: 18)
        return font
    }

    // Шрифт для текста кнопок
    class func mainButtonText() -> UIFont? {
        let font = UIFont(name: "Lato-Black", size: 18)
        return font
    }

    // Шрифт для текста кнопок
    class func headlineText() -> UIFont? {
        let font =  UIFont(name: "Lato-Bold", size: 34)
        return font
    }

    // Шрифт для имени приложения
    class func appNameText() -> UIFont? {
        let font =  UIFont(name: "Lato-Black", size: 32)
        return font
    }
}
