//
//  AuthorizationData.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

public struct AuthorizationData: Codable {
    
    // MARK: - Public properties
    
    public let accessToken: String
    public let refreshToken: String
    
    // MARK: - Initializers
    
    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
