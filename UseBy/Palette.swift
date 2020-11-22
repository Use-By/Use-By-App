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
    static let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)

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

    // Главный акцентный цвет приложения (розовый)
    static let mainActionColor = UIColor(red: 255/255, green: 97/255, blue: 128/255, alpha: 1.0)
    // Второй акцентный цвет приложения (персиковый)
    static let secondaryActionColor = UIColor(red: 254/255, green: 169/255, blue: 155/255, alpha: 1.0)
    static let disabledColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)

    // Цвета иконок
    static let defaultIconColor = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1.0)
    static let inversedIconColor = UIColor.white
    static let actionIconColor = UIColor(red: 255/255, green: 97/255, blue: 128/255, alpha: 1.0)
    static let actionIconShadowColor = UIColor(red: 255/255, green: 204/255, blue: 215/255, alpha: 1.0)
    static let secondaryIconColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0)
    static let inactiveIconColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)

    static let inputDividerColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15)

    // Цвета для фильтров
    static let filterControlBackground = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
    static let filterHighlightColor = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1.0)
}

struct Fonts {
    // Основной текст
    static let mainText = UIFont(name: "Lato-Regular", size: 18)

    // Шрифт для текста кнопок
    static let mainButtonText = UIFont(name: "Lato-Black", size: 18)

    // Заголовки экранов
    static let headlineText = UIFont(name: "Lato-Bold", size: 34)

    // Крупные надписи на экране
    static let largeTitleText = UIFont(name: "Lato-Regular", size: 24)

    // Шрифт для имени приложения
    static let appNameText = UIFont(name: "Lato-Black", size: 32)

    // Шрифт для мелких заголовков
    static let smallHeadlineText = UIFont(name: "Lato-Bold", size: 15)
}
