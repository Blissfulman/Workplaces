//
//  UserID.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

public struct UserID: Codable {
    
    public let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "user_id"
    }
}