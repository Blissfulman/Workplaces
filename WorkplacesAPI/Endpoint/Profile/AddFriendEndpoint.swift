//
//  AddFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct AddFriendEndpoint: EmptyEndpoint {
        
    private let userID: UserID
    
    public init(userID: User.ID) {
        self.userID = UserID(value: userID)
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "me/friends")!, body: .json(try JSONEncoder.default.encode(userID)))
    }
}
