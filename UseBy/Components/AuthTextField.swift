//
//  AuthTextField.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 22.10.2020.
//

import Foundation
import UIKit

class AuthTextField: UIView {
    public let purpose: TextFieldPurpose
    public let field: UITextField = UITextField()

    private let textFieldHeight = 60
    private let dividerHeight = 1
    private let totalHeight = 61

    public enum TextFieldPurpose {
        case password
        case name
        case email
    }

    init(purpose: TextFieldPurpose = .name) {
        self.purpose = purpose
        super.init(frame: .zero)

        configureTextField()

        let divider: UIView = UIView()
        divider.backgroundColor = Colors.inputDividerColor
        divider.translatesAutoresizingMaskIntoConstraints = false

        addSubview(field)
        addSubview(divider)

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(totalHeight)
        }

        field.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(self)
        }
        divider.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(dividerHeight)
            make.width.equalTo(self)
            make.top.equalTo(field.snp.bottom)
        }
    }

    private func configureTextField() {
        field.textColor = Colors.mainTextColor
        field.font = Fonts.mainText
        field.clearButtonMode =  UITextField.ViewMode.whileEditing
        field.borderStyle = UITextField.BorderStyle.none

        switch purpose {
        case .email:
            field.placeholder = "email".localized
            field.isSecureTextEntry = false
        case .name:
            field.placeholder = "name".localized
            field.isSecureTextEntry = false
        case .password:
            field.placeholder = "password".localized
            field.isSecureTextEntry = true
        }
    }

    required init?(coder: NSCoder) {
        self.purpose = .name
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

    public func validate() -> ValidationError? {
        return validateTextField(field: self.field, fieldType: self.purpose)
    }

    public func isEmpty() -> Bool {
        return field.text?.isEmpty ?? true
    }
}
