//
//  AddFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct AddFriendEndpoint: EmptyEndpoint {
    
    // MARK: - Private properties
    
    private let userID: UserID
    
    // MARK: - Initializers
    
    public init(userID: User.ID) {
        self.userID = UserID(value: userID)
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "me/friends")!, body: .json(try encoder.encode(userID)))
    }
}
