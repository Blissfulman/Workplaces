//
//  AuthorizationServiceError.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.05.2021.
//

import Foundation
import WorkplacesAPI

enum AuthorizationServiceError: Error, LocalizedError {
    case credentialsInvalid
    case emailValidationError
    case passwordValidationError
    case dublicateUserError
    case unexpectedError
    
    // MARK: - Public properties
    
    var errorDescription: String? {
        switch self {
        case .credentialsInvalid:
            return "Email или пароль указаны неверно"
        case .emailValidationError:
            return "Email имеет недопустимый формат"
        case .passwordValidationError:
            return """
            Пароль имеет недопустимый формат.
            Он должен быть не менее 8 символов, а также содержать заглавные, строчные буквы и цифры.
            """
        case .dublicateUserError:
            return "Пользователь с указанным email уже зарегистрирован"
        case .unexpectedError:
            return "Непредвиденная ошибка авторизации"
        }
    }
    
    // MARK: - Initializers
    
    init(error: Error) {
        guard let apiError = error as? APIError else {
            self = .unexpectedError
            return
        }
        switch apiError.code {
        case .credentialsInvalid:
            self = .credentialsInvalid
        case .emailValidationError:
            self = .emailValidationError
        case .passwordValidationError:
            self = .passwordValidationError
        case .dublicateUserError:
            self = .dublicateUserError
        default:
            self = .unexpectedError
        }
    }
}
