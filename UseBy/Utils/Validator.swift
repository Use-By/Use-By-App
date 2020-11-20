//
//  Validator.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/25/20.
//

import Foundation
import UIKit

struct ValidationError {
    let text: String
}

struct ValidationParams {
    static let passwordLength = 6
}

func validatePassword(field: UITextField) -> ValidationError? {
    guard let text = field.text else {
        return nil
    }
    let isValid = text.count > ValidationParams.passwordLength

    if !isValid {
        return ValidationError(text: "weak-password-error".localized)
    }

    return nil
}

func validateTextField(field: UITextField, fieldType: TextField.TextFieldPurpose) -> ValidationError? {
    switch fieldType {
    case .password:
        return validatePassword(field: field)

    default:
        return nil
    }
}

func validateTextFields(fields: [TextField]) -> [ValidationError] {
    var errors: [ValidationError] = []

    fields.forEach { field in
        if let error = field.validate() {
            errors.append(error)
        }
    }

    return errors
}

func getErrorsTexts(validationErrors: [ValidationError]) -> String {
    return validationErrors.map { $0.text }.joined(separator: "\n")
}
