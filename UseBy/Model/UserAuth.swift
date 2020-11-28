//
//  UserModel.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/18/20.
//

import Foundation
import Firebase

protocol UserAuthModelProtocol {
    func createAccount(email: String, password: String, completion: @escaping (UserAuthError?) -> Void)
    func login(email: String, password: String, completion: @escaping (UserAuthError?) -> Void)
}

enum UserAuthError {
    // TODO Дополнить енам ошибками
    case emailAlreadyInUse
    case invalidEmail
    case unknownError
    case wrongPassword
    case userNotFound
}

func getUserAuthErrorText(error: UserAuthError) -> String {
    // TODO  Написать правильные тексты
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
    }
}

class UserAuthModel: UserAuthModelProtocol {

    func createAccount(email: String, password: String, completion: @escaping (UserAuthError?) -> Void) {
        // TODO Нужно при создании выставлять name для пользователя

        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                if (error as NSError).code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    completion(UserAuthError.emailAlreadyInUse)
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

//            if let error = error as? AuthErrorCode {
//                switch error {
//                case .wrongPassword:
//                    completion(UserAuthError.wrongPassword)
//
//                case .userNotFound:
//                    completion(UserAuthError.userNotFound)
//
//                case .invalidEmail:
//                    completion(UserAuthError.invalidEmail)
//
//                default :
//                    completion(UserAuthError.unknownError)
//
//                }
//                completion(nil)
//            }
        }
    }
}
