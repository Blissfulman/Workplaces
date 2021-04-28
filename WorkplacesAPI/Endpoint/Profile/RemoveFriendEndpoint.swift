//
//  RemoveFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RemoveFriendEndpoint: EmptyEndpoint {
    
    private let userID: User.ID
    
    public init(userID: User.ID) {
        self.userID = userID
    }
    
    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "me/friends")!
            .appendingPathComponent(userID)
        return delete(url)
    }
}
