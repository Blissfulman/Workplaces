//
//  TestError.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 23.04.2021.
//

import Foundation

enum TestError: Error {
    case credentialError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .credentialError:
            return "Credential error"
        case .unknownError:
            return "Unknown error"
        }
    }
}
