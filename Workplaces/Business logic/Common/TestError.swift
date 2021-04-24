//
//  TestError.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 23.04.2021.
//

import Foundation

enum TestError: Error, LocalizedError {
    case credentialError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .credentialError:
            return "Credential error"
        case .unknownError:
            return "Unknown error"
        }
    }
}
