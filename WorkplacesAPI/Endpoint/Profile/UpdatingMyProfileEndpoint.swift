//
//  UpdatingMyProfileEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct UpdatingMyProfileEndpoint: JsonEndpoint {
    
    public typealias Content = User
    
    private let user: User
    
    public init(user: User) {
        self.user = user
    }
    
    public func makeRequest() throws -> URLRequest {
        patch(URL(string: "me")!, body: .json(try JSONEncoder.default.encode(user)))
    }
}
