//
//  LoginEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LoginEndpoint: JsonEndpoint {
    
    public typealias Content = AuthorizationData
    
    let userCredentials: UserCredentials
    
    public init(userCredentials: UserCredentials) {
        self.userCredentials = userCredentials
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/login")!, body: .json(try JSONEncoder.default.encode(userCredentials)))
    }
}
