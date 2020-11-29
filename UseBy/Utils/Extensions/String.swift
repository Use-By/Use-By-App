//
//  String.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/11/20.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func pluralizeString(count: Int) -> String {
        return String.localizedStringWithFormat(self.localized, count)
    }
}
