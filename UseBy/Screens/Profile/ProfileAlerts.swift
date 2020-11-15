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
    case non
}

class Alert {
    private var alert: UIAlertController

    init(title: String, message: String? = nil, placeholder1: String? = nil,
         placeholder2: String? = nil, action: AlertActions) {
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        switch action {
        case .save:
            alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
            let actionSave = UIAlertAction(title: "save".localized, style: .default, handler: { _ in
                // save different data in different place
                // saveDataFromAlert(data: Dat
            })
            alert.addAction(actionSave)
        case .non:
            alert.addAction(UIAlertAction(title: "ok".localized, style: .cancel, handler: nil))

        }

        if placeholder1 != nil {
        alert.addTextField(configurationHandler: { textField in
                textField.placeholder = placeholder1
            })
        }
        if placeholder2 != nil {
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = placeholder2
            })
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
