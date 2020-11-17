//
//  TextField.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 22.10.2020.
//

import Foundation
import UIKit

class TextField: UITextField {
    private let purpose: TextFieldPurpose
    internal enum TextFieldPurpose {
        case password
        case name
        case email
    }

    init(purpose: TextFieldPurpose = .name) {
        self.purpose = purpose
        super.init(frame: .zero)
        textColor = Colors.mainTextColor
        font = Fonts.mainText
        clearButtonMode =  .whileEditing
        borderStyle = UITextField.BorderStyle.none
        switch self.purpose {
        case .email:
            placeholder = "email".localized
        case .name:
            placeholder = "name".localized
        case .password:
            placeholder = "password".localized
            self.isSecureTextEntry = true
        }
    }

    required init?(code decoder: NSCoder) {
        self.purpose = .name
        super.init(coder: decoder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
