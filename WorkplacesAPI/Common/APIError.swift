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

    public init(
        code: Code,
        description: String? = nil) {

        self.code = code
        self.description = description
    }
}

// MARK: - General Error Code

extension APIError.Code {
    
    /// Invalid Token Error.
    public static let tokenInvalid = APIError.Code("token_invalid")
    
}
