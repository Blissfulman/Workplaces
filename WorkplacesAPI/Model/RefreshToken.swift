//
//  RefreshToken.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

public struct RefreshToken: Encodable {
    
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case value = "token"
    }
}
