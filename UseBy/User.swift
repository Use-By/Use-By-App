//
//  UserModel.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/18/20.
//

import Foundation
import Firebase

struct User {
    var name: String
    var email: String
}

protocol UserModelProtocol {
    func get() -> User
    func changeEmail(newEmail: String)
    func changePassword(newPassword: String)
    func changeName(newName: String)
}

class UserModel: UserModelProtocol {
    func changeEmail(newEmail: String) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { (_) in
          // ...
        }
    }

    func changePassword(newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
            if error != nil {
                // Выводим alert
            }
        }
    }

    func changeName(newName: String) {
        return
    }

    func get() -> User {
        let user = Auth.auth().currentUser
        guard let currentUser = user else {
            // добавить alert
            return User(name: "", email: "")
        }

        return User(name: currentUser.displayName ?? "", email: currentUser.email ?? "")
    }
}
