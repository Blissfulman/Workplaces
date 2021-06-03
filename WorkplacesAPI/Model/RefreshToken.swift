//
//  RefreshToken.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

public struct RefreshToken: Encodable {
    
    // MARK: - Nested types
    
    private enum CodingKeys: String, CodingKey {
        case value = "token"
    }
    
    // MARK: - Public properties
    
    let value: String
}
