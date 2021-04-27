//
//  APIError.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

/// Error from API.
public struct APIError: Decodable, Error, LocalizedError {
    
    public enum Code: String, Decodable {
        case credentialsInvalid = "INVALID_CREDENTIALS"
        case tokenInvalid = "INVALID_TOKEN"
        case emailValidationError = "EMAIL_VALIDATION_ERROR"
        case passwordValidationError = "PASSWORD_VALIDATION_ERROR"
        case dublicateUserError = "DUPLICATE_USER_ERROR"
        case serializationError = "SERIALIZATION_ERROR"
        case fileNotFoundError = "FILE_NOT_FOUND_ERROR"
        case tooBigFileError = "TOO_BIG_FILE_ERROR"
        case badFileExtensionError = "BAD_FILE_EXTENSION_ERROR"
        case genericError = "GENERIC_ERROR"
        case unknownError = "UNKNOWN_ERROR"
    }
    
    /// Error code.
    public let code: Code
    
    /// Error message.
    public let message: String?
    
    public var errorDescription: String? {
        switch code {
        case .credentialsInvalid:
            return "Email или пароль указаны неверно"
        case .tokenInvalid:
            return "Проблема с access или refresh токеном"
        case .emailValidationError:
            return "Email имеет недопустимый формат"
        case .passwordValidationError:
            return "Пароль имеет недопустимый формат"
        case .dublicateUserError:
            return "Пользователь с указанным email уже зарегистрирован"
        case .serializationError:
            return "Входные данные не соответсвуют модели"
        case .fileNotFoundError:
            return "Запрошенное изображение не найдено"
        case .tooBigFileError:
            return "Загружаемое изображение больше 5Мб"
        case .badFileExtensionError:
            return "Изображение имеет недопустимый формат"
        case .genericError:
            return "Общая ошибка. \(message ?? "")"
        case .unknownError:
            return "Неизвестная ошибка. \(message ?? "")"
        }
    }
}
