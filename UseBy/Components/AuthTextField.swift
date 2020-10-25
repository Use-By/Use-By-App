//
//  TextField.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 22.10.2020.
//

import Foundation
import UIKit
import SnapKit

class AuthTextField: UITextField {
    private let purpose: TextFieldPurpose
    public enum TextFieldPurpose {
        case password
        case name
        case email
    }

    init(purpose: TextFieldPurpose = .name) {
        self.purpose = purpose
        super.init(frame: .zero)
        textColor = Colors.mainTextColor
        font = Fonts.mainText
        clearButtonMode =  UITextField.ViewMode.whileEditing
        borderStyle = UITextField.BorderStyle.none

        switch self.purpose {
        case .email:
            placeholder = "email".localized
            self.isSecureTextEntry = false
        case .name:
            placeholder = "name".localized
            self.isSecureTextEntry = false
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

    public func validate() -> ValidationError? {
        return validateTextField(field: self, fieldType: self.purpose)
    }

    public func isEmpty() -> Bool {
        return text?.count == 0
    }
}
