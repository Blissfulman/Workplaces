//
//  RemoveFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RemoveFriendEndpoint: EmptyEndpoint {
    
    // MARK: - Private properties
    
    private let userID: User.ID
    
    // MARK: - Initializers
    
    public init(userID: User.ID) {
        self.userID = userID
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "me/friends")!.appendingPathComponent(userID)
        return delete(url)
    }
}
