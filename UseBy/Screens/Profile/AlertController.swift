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
        self.present(alertChange, animated: false, completion: nil)
    }
   override func viewDidAppear(_ animated: Bool) {
        self.present(alertChange, animated: false, completion: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension UIAlertController {

    /*func lableIfNotValid() {
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 270, height: 18))
        label.textAlignment = .center
        label.textColor = .red
        label.isHidden = true
        label.text = "your_password_is_shorter_than_6_characters_or_your_passwords_don't_match".localized
        view.addSubview(label) // dont show on the screen
        label.isHidden = false
    }*/
    func isValidEmail(_ email: String) -> Bool {
        return email.count > 0 && NSPredicate(format: "self matches %@",
                                              "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}").evaluate(with: email)
    }

    func isValidPassword(_ password: String, _ confirmPassword: String) -> Bool {
        return password.count >= 6 && password == confirmPassword
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
            action.isEnabled = isValidPassword(password, confirmPassword)
        }
    }
    @objc func textDidChangeInEmail() {
        if let email = textFields?[0].text,
           let action = actions.first {
            action.isEnabled = isValidEmail(email)
        }
    }

}
