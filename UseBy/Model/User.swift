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
    func changeEmail(newEmail: String, completion: @escaping (UserError?) -> Void)
    func changePassword(newPassword: String, completion: @escaping (UserError?) -> Void)
    func changeName(newName: String, completion: @escaping (UserError?) -> Void)
    func signOut()
}

enum UserError {
    case emailAlreadyInUse
    case invalidEmail
    case unknownError
}

func getUserErrorText(error: UserError) -> String {
    switch error {
    case .emailAlreadyInUse:
        return "errorEmailAlreadyInUse".localized

    case .invalidEmail:
        return "errorInvalidEmail".localized

    case .unknownError:
        return "unknownError".localized
    }
}

class UserModel: UserModelProtocol {
    func signOut() {
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          return
        }
    }

    func changeEmail(newEmail: String, completion: @escaping (UserError?) -> Void) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { (error) in
            if let error = error {
                if (error as NSError).code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    completion(.emailAlreadyInUse)

                    return
                }

                if (error as NSError).code == AuthErrorCode.invalidEmail.rawValue {
                    completion(.invalidEmail)

                    return

                }

                completion(.unknownError)

                return
            }
            completion(nil)
        }
    }

    func changePassword(newPassword: String, completion: @escaping (UserError?) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
            if let error = error {
                completion(.unknownError)
            }

            completion(nil)
        }
    }

    func changeName(newName: String, completion: @escaping (UserError?) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = newName
        changeRequest?.commitChanges { (error) in
            if let error = error {
                completion(.unknownError)
            }

            completion(nil)
        }
    }

    func get() -> User {
        let user = Auth.auth().currentUser

        guard let currentUser = user else {
            Alert(title: "ops".localized,
                  message: "something_went_wrong_with_authorization".localized,
                  placeholder1: nil, placeholder2: nil, action: .none)

            return User(name: "", email: "", authWithGoogle: false)
        }

        if GIDSignIn.sharedInstance()?.currentUser != nil {
            return User(name: currentUser.displayName ?? "", email: currentUser.email ?? "", authWithGoogle: true)
        }

        return User(name: currentUser.displayName ?? "", email: currentUser.email ?? "", authWithGoogle: false)
    }
}
