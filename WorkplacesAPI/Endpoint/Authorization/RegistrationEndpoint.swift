//
//  RegistrationEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RegistrationEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = AuthorizationData
    
    // MARK: - Private properties
    
    private let userCredentials: UserCredentials
    
    // MARK: - Initializers
    
    public init(userCredentials: UserCredentials) {
        self.userCredentials = userCredentials
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "auth/registration")!, body: .json(try encoder.encode(userCredentials)))
    }
}
