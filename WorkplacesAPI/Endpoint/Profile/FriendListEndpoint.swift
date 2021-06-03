//
//  FriendListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct FriendListEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = [User]
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "me/friends")!)
    }
}
