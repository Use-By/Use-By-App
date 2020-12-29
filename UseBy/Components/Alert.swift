//
//  ProfileAlerts.swift
//  UseBy
//
//  Created by Admin on 01.11.2020.
//

import Foundation
import UIKit

enum AlertActions {
    case save
    case none
}

class Alert {
    private var alert: UIAlertController
    init(title: String, message: String? = nil, placeholder1: String? = nil,
         placeholder2: String? = nil, action: AlertActions, secure: Bool?=nil) {
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if placeholder1 != nil {
        alert.addTextField(configurationHandler: { textField in
                textField.placeholder = placeholder1
            if secure != nil {
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false}
            })
        }
        if placeholder2 != nil {
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = placeholder2
            if secure != nil {
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false}
            })
        }
        switch action {
        case .save:
            alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
            let actionSave = UIAlertAction(title: "save".localized, style: .default, handler: { _ in
                guard let fields = self.alert.textFields else {
                    _ = Alert(title: "ops".localized, message: getUserErrorText(error: .unknownError),
                          placeholder1: nil, placeholder2: nil, action: .none)
                    return
                }
                let _: [String] = fields.map { field in
                    return field.text ?? ""
                }
            })
            alert.addAction(actionSave)
        case .none:
            alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))
        }

        if let app = UIApplication.shared.delegate as? AppDelegate,
           let rootViewController = app.window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
