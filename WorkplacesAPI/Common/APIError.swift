//
//  APIError.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

/// Error from API.
public struct APIError: Decodable, Error {
    
    public struct Code: RawRepresentable, Decodable, Equatable {
        
        public var rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    /// Error code.
    public let code: Code
    
    /// Error description.
    public let description: String?
    
    /// Error message.
    public let message: String?
    
    public init(code: Code, description: String? = nil, message: String? = nil) {
        self.code = code
        self.description = description
        self.message = message
    }
}

// MARK: - General Error Code

extension APIError.Code {
    
//    public static let tokenInvalid = APIError.Code("token_invalid")
    
    public static let credentialsInvalid = APIError.Code("INVALID_CREDENTIALS")
    public static let tokenInvalid = APIError.Code("INVALID_TOKEN")
    public static let emailValidationError = APIError.Code("EMAIL_VALIDATION_ERROR")
    public static let passwordValidationError = APIError.Code("PASSWORD_VALIDATION_ERROR")
    public static let dublicateUserError = APIError.Code("DUPLICATE_USER_ERROR")
    public static let serializationError = APIError.Code("SERIALIZATION_ERROR")
    public static let fileNotFoundError = APIError.Code("FILE_NOT_FOUND_ERROR")
    public static let tooBigFileError = APIError.Code("TOO_BIG_FILE_ERROR")
    public static let badFileExtensionError = APIError.Code("BAD_FILE_EXTENSION_ERROR")
}
