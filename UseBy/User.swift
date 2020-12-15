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
    func changeEmail(newEmail: String, completion: @escaping (Error?) -> Void)
    func changePassword(newPassword: String, completion: @escaping (Error?) -> Void)
    func changeName(newName: String, completion: @escaping (Error?) -> Void)
    func singOut()
}

class UserModel: UserModelProtocol {

    func singOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    func changeEmail(newEmail: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { (error) in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }

    func changePassword(newPassword: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }

    func changeName(newName: String, completion: @escaping (Error?) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = newName
        changeRequest?.commitChanges { (error) in
            if let error = error {
                completion(error)
            }
            completion(nil)
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
