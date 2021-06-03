//
//  UserID.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

public struct UserID: Encodable {
    
    // MARK: - Nested types
    
    private enum CodingKeys: String, CodingKey {
        case value = "user_id"
    }
    
    // MARK: - Public properties
    
    let value: User.ID
}
