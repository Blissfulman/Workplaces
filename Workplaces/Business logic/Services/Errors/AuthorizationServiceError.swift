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
            return "Email or password are incorrect".localized()
        case .emailValidationError:
            return "Email is in invalid format".localized()
        case .passwordValidationError:
            return "Invalid password. Please, use uppercase, lowercase letters and numbers.".localized() +
                " Minimum password length is 8 symbols.".localized()
        case .dublicateUserError:
            return "Unable to create user. The user with the specified email is already registered".localized()
        case .unexpectedError:
            return "Unexpected authorization error".localized()
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
