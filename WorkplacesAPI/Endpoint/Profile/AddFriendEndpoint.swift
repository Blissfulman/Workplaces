//
//  AddFriendEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct AddFriendEndpoint: EmptyEndpoint {
        
    private let userID: String
    
    public init(userID: String) {
        self.userID = userID
    }
    
    public func makeRequest() throws -> URLRequest {
        let userData = try JSONEncoder.default.encode(userID)
        let body = HTTPBody(data: userData, contentType: "multipart/form-data")
        return post(URL(string: "me/friends")!, body: body)
    }
}
