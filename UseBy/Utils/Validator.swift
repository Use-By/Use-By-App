//
//  Validator.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 10/25/20.
//

import Foundation

struct ValidationError {
    let text: String
}

struct ValidationParams {
    static let passwordLength = 6
}

func validatePassword(field: AuthTextField) -> ValidationError? {
    guard let text = field.text else {
        return nil
    }
    let isValid = text.count > ValidationParams.passwordLength

    if !isValid {
        return ValidationError(text: "weak-password-error".localized)
    }

    return nil
}

func isEmptyField(field: AuthTextField) -> Bool? {
    return field.text?.count != 0
}

func validateTextField(field: AuthTextField, fieldType: AuthTextField.TextFieldPurpose) -> ValidationError? {
    switch fieldType {
    case .password:
        return validatePassword(field: field)

    default:
        return nil
    }
}

func validateTextFields(fields: [AuthTextField]) -> [ValidationError] {
    var errors: [ValidationError] = []

    fields.forEach { field in
        let error = field.validate()

        if let error = error {
            errors.append(error)
        }
    }

    return errors
}

func getErrorsTexts(validationErrors: [ValidationError]) -> String {
    return validationErrors.map { error in
        return error.text
    }.joined(separator: "\n")
}
