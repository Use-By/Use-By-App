//
//  TableLabel.swift
//  UseBy
//
//  Created by Admin on 31.10.2020.
//

import Foundation
import UIKit

final class TableLable: UILabel {
    private let theme: TableLableTheme

    enum TableLableTheme {
            case normal
    }

    init(theme: TableLableTheme = .normal) {
        self.theme = theme
        super.init(frame: .zero)
        text = "app-name".localized.uppercased()
        font = Fonts.mainText

        switch self.theme {
        case .normal:
            textColor = Colors.secondaryTextColor
        }
    }

   required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }
}
