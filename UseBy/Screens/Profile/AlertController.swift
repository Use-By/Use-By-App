//
//  AlertController.swift
//  UseBy
//
//  Created by Admin on 06.12.2020.
//
import Foundation
import UIKit

enum AlertControllerChange {
    case changeEmail
    case changePassword
    case changeName
}

class AlertController: UIViewController {
    var alertTextField1 = UITextField()
    var alertTextField2 = UITextField()
    var texts = [String]()
    var isValid: Bool = true

    private var alertChange = UIAlertController()

    func getTextFromInput() -> [String] {
        return alertChange.textFields?.map {$0.text!} ?? []
    }

    init(title: String, message: String? = nil, placeholder1: String,
         placeholder2: String? = nil, secure: Bool?=nil,
         changeWhat: AlertControllerChange, saveDataFromAlert: (( _: [String]) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertChange = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionSave = UIAlertAction(title: "save".localized, style: .default, handler: { (_) -> Void in
            let text = self.getTextFromInput()
            saveDataFromAlert?(text)
            self.dismiss(animated: true, completion: nil)
        })
        actionSave.isEnabled = false
        self.alertChange.addAction(actionSave)
        let actionCancel = UIAlertAction(title: "cancel".localized, style: .cancel, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        self.alertChange.addAction(actionCancel)
        switch changeWhat {
        case .changeEmail:
            self.alertChange.addTextField {
                $0.placeholder = placeholder1
                $0.addTarget(self.alertChange, action: #selector
                                (self.alertChange.textDidChangeInEmail), for: .editingChanged)
            }
        case .changeName:
            self.alertChange.addTextField {
                $0.placeholder = placeholder1
                $0.addTarget(self.alertChange, action: #selector(self.alertChange.textDidChange), for: .editingChanged)
            }
        case .changePassword:
            self.alertChange.addTextField {
                $0.placeholder = placeholder1
                $0.isSecureTextEntry = true
                $0.addTarget(self.alertChange, action: #selector
                                (self.alertChange.textDidChangeInPassword), for: .editingChanged)
            }
            self.alertChange.addTextField {
                $0.placeholder = placeholder2
                $0.isSecureTextEntry = true
                $0.addTarget(self.alertChange, action: #selector(
                                self.alertChange.textDidChangeInPassword), for: .editingChanged)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    override func viewDidAppear(_ animated: Bool) {
        self.present(alertChange, animated: false, completion: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension UIAlertController {
    func setColorMessage(color: UIColor) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)

        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: color],
                                      range: NSRange(location: 0, length: message.utf8.count))
        self.setValue(attributeString, forKey: "attributedMessage")
    }

    func messageIfNotValid(validemail: Bool?, validepassword: Bool?) {
        if validepassword == false {
            message = "your_password_is_shorter_than_6_characters_or_your_passwords_don't_match".localized
        } else if validepassword == true {
            message = nil
        }
        if validemail == false {
            message = "invalid_email".localized
        } else if validemail == true {
            message = nil
        }
        setColorMessage(color: UIColor.red)
    }

    @objc func textDidChange() {
        var alertTextFieldNotEmpty = false
        if textFields?[0].text?.count != nil {
            alertTextFieldNotEmpty = true
        }
        let action = actions.first
        action?.isEnabled = alertTextFieldNotEmpty
    }

    @objc func textDidChangeInPassword() {
        if let password = textFields?[0].text,
           let confirmPassword = textFields?[1].text,
           let action = actions.first {
            messageIfNotValid(validemail: nil, validepassword:

                                isValidPassword(password, confirmPassword) )
            action.isEnabled = isValidPassword(password, confirmPassword)
        }
    }
    @objc func textDidChangeInEmail() {
        setColorMessage(color: UIColor.red)
        if let email = textFields?[0].text,
           let action = actions.first {
            messageIfNotValid(validemail: isValidEmail(email), validepassword: nil)
            action.isEnabled = isValidEmail(email)
        }
    }

}
