//
//  UserModel.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/18/20.
//

import Foundation
import Firebase
import GoogleSignIn

struct User {
    var name: String
    var email: String
    var authWithGoogle: Bool
}

protocol UserModelProtocol {
    func get() -> User
    func changeEmail(newEmail: String)
    func changePassword(newPassword: String)
    func changeName(newName: String)
    func singOut()
}

class UserModel: UserModelProtocol {
    func singOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    func changeEmail(newEmail: String) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { (error) in
            if error != nil {
                print("err")
                _ = Alert(title: "ops".localized,
                      message: "something_went_wrong"
    .localized,
                      placeholder1: nil, placeholder2: nil, action: .none)
            } else {
                print("Email changed successfully")
             }
        }
    }

    func changePassword(newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
            if error != nil {
                print("err")
                _ = Alert(title: "ops".localized,
                      message: "something_went_wrong"
    .localized,
                      placeholder1: nil, placeholder2: nil, action: .none)
            } else {
                print("Password changed successfully")
             }
        }
    }

    func changeName(newName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = newName
        changeRequest?.commitChanges { (error) in
            if error != nil {
                print("err")
                _ = Alert(title: "ops".localized,
                      message: "something_went_wrong"
    .localized,
                      placeholder1: nil, placeholder2: nil, action: .none)
            } else {
                print("Name changed successfully")
            }
        }
    }

    func get() -> User {
        let user = Auth.auth().currentUser
        guard let currentUser = user else {
            _ = Alert(title: "ops".localized,
                  message: "something_went_wrong_with_authorization"
.localized,
                  placeholder1: nil, placeholder2: nil, action: .none)
            return User(name: "", email: "", authWithGoogle: false)
        }

        return User(name: currentUser.displayName ?? "", email: currentUser.email ?? "", authWithGoogle: true)
    }
}
