//
//  RefreshTokenEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RefreshTokenEndpoint: JsonEndpoint {
    
    public typealias Content = AuthorizationData
    
    let refreshToken: String
    
    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/registration")!, body: nil)// .json(try JSONEncoder.default.encode(credentialData)))
    }
}
