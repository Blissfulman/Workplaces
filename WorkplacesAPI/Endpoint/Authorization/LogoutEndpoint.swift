//
//  LogoutEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LogoutEndpoint: EmptyEndpoint {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/logout")!, body: nil)
    }
}
