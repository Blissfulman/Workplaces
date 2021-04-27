//
//  RefreshTokenEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RefreshTokenEndpoint: JsonEndpoint {
    
    public typealias Content = AuthorizationData
    
    let refreshToken: RefreshToken
    
    public init(refreshToken: String) {
        self.refreshToken = RefreshToken(value: refreshToken)
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/refresh")!, body: .json(try JSONEncoder.default.encode(refreshToken)))
    }
}
