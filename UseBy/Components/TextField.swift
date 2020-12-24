//
//  TextField.swift
//  UseBy
//
//  Created by Anastasiia Malaia on 22.10.2020.
//

import Foundation
import UIKit
import SnapKit

class TextField: UIView {
    private let purpose: TextFieldPurpose
    let textField: UITextField = UITextField()

    private let textFieldHeight = 60
    private let dividerHeight = 1
    private let totalHeight = 61

    enum TextFieldPurpose: Int {
        case password = 0
        case name
        case email
        case tag
    }

    init(purpose: TextFieldPurpose = .name) {
        self.purpose = purpose
        super.init(frame: .zero)

        configureTextField()

        let divider: UIView = UIView()
        divider.backgroundColor = Colors.inputDividerColor
        divider.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textField)
        addSubview(divider)

        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(totalHeight)
        }

        textField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(self)
        }
        divider.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(dividerHeight)
            make.width.equalTo(self)
            make.top.equalTo(textField.snp.bottom)
        }
    }

    private func configureTextField() {
        textField.textColor = Colors.mainTextColor
        textField.font = Fonts.mainText
        textField.clearButtonMode =  .whileEditing
        textField.borderStyle = .none
        textField.tag = purpose.rawValue

        switch purpose {
        case .email:
            textField.placeholder = "email".localized
        case .name:
            textField.placeholder = "name".localized
        case .password:
            textField.placeholder = "password".localized
            textField.isSecureTextEntry = true
        case .tag:
            textField.placeholder = "tag".localized
        }
    }

    required init?(coder: NSCoder) {
        self.purpose = .name
        super.init(coder: coder)
    }

    func validate() -> ValidationError? {
        return validateTextField(field: self.textField, fieldType: self.purpose)
    }

    func isEmpty() -> Bool {
        return textField.text?.isEmpty ?? true
    }
}
