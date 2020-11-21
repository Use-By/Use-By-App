//
//  UserModel.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/18/20.
//

import Foundation
import Firebase

protocol UserAuthModelProtocol {
    func createAccount(email: String, password: String, completion: @escaping ((UserAuthError?) -> Void))
    func login(email: String, password: String)
}

enum UserAuthError {
    // TODO Дополнить енам ошибками
    case emailAlreadyInUse
    case invalidEmail
}

func getUserAuthErrorText(error: UserAuthError) -> String {
    // TODO  Написать правильные тексты
    switch error {
    case .emailAlreadyInUse:
        return "error".localized

    case .invalidEmail:
        return "error".localized
    }
}

class UserAuthModel: UserAuthModelProtocol {
    func createAccount(email: String, password: String, completion: @escaping ((UserAuthError?) -> Void)) {
        // TODO Нужно при создании выставлять name для пользователя

        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                if (error as NSError).code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    completion(UserAuthError.emailAlreadyInUse)

                    return
                }

                if (error as NSError).code == AuthErrorCode.invalidEmail.rawValue {
                    // TODO Указать новую ошибку
                    completion(UserAuthError.emailAlreadyInUse)

                    return
                }

                // TODO  Ошибка сети: Произошла непредвиденная ошибка, попробуйте позже
                completion(UserAuthError.emailAlreadyInUse)

                return
            }

            completion(nil)
        }
    }

    // Добавить completion
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                if (error as NSError).code == AuthErrorCode.wrongPassword.rawValue {
                    // Неправильный пароль
                    // Пользователя с такой почтой и паролем нет
                    // Добавить в енам ошибки, добавить им текст, вызвать completion
                    return
                }

                if (error as NSError).code == AuthErrorCode.invalidEmail.rawValue {
                    // Неправильная почта
                    // Почта введена неверно
                    // Добавить в енам ошибки, добавить им текст, вызвать completion
                    return
                }

                // Ошибка сети: Произошла непредвиденная ошибка, попробуйте позже
                // Добавить в енам ошибки, добавить им текст, вызвать completion
            }
        }
    }
}
