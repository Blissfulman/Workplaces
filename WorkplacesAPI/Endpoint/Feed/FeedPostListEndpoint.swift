//
//  FeedPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy

public struct FeedPostListEndpoint: JsonEndpoint {
    
    public typealias Content = [Post]
    private let token = ""
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        var request = get(URL(string: "feed")!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
