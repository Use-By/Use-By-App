//
//  Palette.swift
//  Файл со всеми цветами, шрифтами приложения
//
//  Created by Nadezda Svoykina on 10/10/20.
//

import Foundation
import UIKit

struct Colors {
    // Цвета текстов
    static let mainTextColor = UIColor.black
    static let inversedTextColor = UIColor.white
    static let secondaryTextColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)

    // Цвета фонов
    static let mainBGColor = UIColor.white
    static let mainActionBGColor = UIColor(red: 254/255, green: 169/255, blue: 155/255, alpha: 0.1)
    static let socialBGColor = UIColor(red: 66/255, green: 103/255, blue: 177/255, alpha: 1.0)
    static let secondaryActionBGColor = UIColor(red: 64/255, green: 188/255, blue: 216/255, alpha: 0.1)
    static let disabledBGColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)

    static func mainBGGradient() -> CAGradientLayer {
        let topColor = Colors.mainActionColor
        let bottomColor = Colors.secondaryActionColor

        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [NSNumber(0.0), NSNumber(1.0)]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations

        return gradientLayer
    }

    static let mainActionColor = UIColor(red: 255/255, green: 97/255, blue: 128/255, alpha: 1.0)
    static let secondaryActionColor = UIColor(red: 254/255, green: 169/255, blue: 155/255, alpha: 1.0)
}

struct Fonts {
    // Основной текст
    static let mainText = UIFont(name: "Lato-Regular", size: 18)

    // Шрифт для текста кнопок
    static let mainButtonText = UIFont(name: "Lato-Black", size: 18)

    // Заголовки экранов
    static let headlineText = UIFont(name: "Lato-Bold", size: 34)

    // Шрифт для имени приложения
    static let appNameText = UIFont(name: "Lato-Black", size: 32)
}
