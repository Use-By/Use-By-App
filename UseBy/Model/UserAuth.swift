//
//  UserModel.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/18/20.
//

import Foundation
import Firebase
import GoogleSignIn

protocol UserAuthModelProtocol {
    func createAccount(email: String, password: String, name: String, completion: @escaping (UserAuthError?) -> Void)
    func login(email: String, password: String, completion: @escaping (UserAuthError?) -> Void)
}

enum UserAuthError {
    case emailAlreadyInUse
    case invalidEmail
    case unknownError
    case wrongPassword
    case userNotFound
    case googleSignInError
}

func getUserAuthErrorText(error: UserAuthError) -> String {
    switch error {
    case .emailAlreadyInUse:
        return "errorEmailAlreadyInUse".localized

    case .invalidEmail:
        return "errorInvalidEmail".localized

    case .unknownError:
        return "unknownError".localized

    case .wrongPassword:
        return "errorWrongPassword".localized

    case .userNotFound:
        return "errorUserNotFound".localized

    case .googleSignInError:
        return "google-error-description".localized
    }
}

class UserAuthModel: UserAuthModelProtocol {
    func createAccount(email: String, password: String, name: String, completion: @escaping (UserAuthError?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                if (error as NSError).code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    completion(UserAuthError.emailAlreadyInUse)
                    return
                }

                if (error as NSError).code == AuthErrorCode.invalidEmail.rawValue {
                    completion(UserAuthError.invalidEmail)
                    return
                }
                
                completion(UserAuthError.unknownError)

                return
            }

            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges { (error) in
                if error != nil {
                    completion(UserAuthError.unknownError)

                    return
                }

                completion(nil)
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (UserAuthError?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                if (error as NSError).code == AuthErrorCode.wrongPassword.rawValue {
                    completion(UserAuthError.wrongPassword)
                    return
                }

                if (error as NSError).code == AuthErrorCode.userNotFound.rawValue {
                    completion(UserAuthError.userNotFound)
                    return
                }

                if (error as NSError).code == AuthErrorCode.invalidEmail.rawValue {
                    completion(UserAuthError.invalidEmail)
                    return

                } else {
                    completion(UserAuthError.unknownError)

                    return
                }
            }

            completion(nil)
        }
    }

    func loginWithCredential(credential: AuthCredential, completion: @escaping (UserAuthError?) -> Void) {
        Auth.auth().signIn(with: credential) { (_, error) in
            if error != nil {
                completion(UserAuthError.googleSignInError)
            }

            completion(nil)
        }
    }
}
