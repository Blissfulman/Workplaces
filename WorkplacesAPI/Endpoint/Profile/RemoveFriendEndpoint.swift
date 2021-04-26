//
//  RemoveFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct RemoveFriendEndpoint: EmptyEndpoint {
    
    private let userID: String
    
    public init(userID: User.ID) {
        self.userID = userID
    }
    
    public func makeRequest() throws -> URLRequest {
        delete(URL(string: "me/friends/\(userID)")!)
    }
}
