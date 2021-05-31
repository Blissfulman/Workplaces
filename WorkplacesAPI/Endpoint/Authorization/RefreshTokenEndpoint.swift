//
//  RefreshTokenEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RefreshTokenEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = AuthorizationData
    
    // MARK: - Private properties
    
    private let refreshToken: RefreshToken
    
    // MARK: - Initializers
    
    public init(refreshToken: String) {
        self.refreshToken = RefreshToken(value: refreshToken)
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/refresh")!, body: .json(try encoder.encode(refreshToken)))
    }
}
