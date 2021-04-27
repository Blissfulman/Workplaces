//
//  RefreshToken.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

public struct RefreshToken: Codable {
    
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "refresh_token"
    }
}
