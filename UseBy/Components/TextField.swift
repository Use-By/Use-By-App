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
    let field: UITextField = UITextField()

    private let textFieldHeight = 60
    private let dividerHeight = 1
    private let totalHeight = 61

    enum TextFieldPurpose {
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
        field.clearButtonMode =  .whileEditing
        field.borderStyle = .none

        switch purpose {
        case .email:
            field.placeholder = "email".localized
        case .name:
            field.placeholder = "name".localized
        case .password:
            field.placeholder = "password".localized
            field.isSecureTextEntry = true
        }
    }

    required init?(coder: NSCoder) {
        self.purpose = .name
        super.init(coder: coder)
    }

    func validate() -> ValidationError? {
        return validateTextField(field: self.field, fieldType: self.purpose)
    }

    func isEmpty() -> Bool {
        return field.text?.isEmpty ?? true
    }
}
