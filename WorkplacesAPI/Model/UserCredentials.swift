//
//  UserCredentials.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

public struct UserCredentials: Encodable {
    
    // MARK: - Public properties
    
    public let email: String?
    public let password: String?
    
    // MARK: - Initializers
    
    public init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
}
