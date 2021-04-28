//
//  FeedPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy

public struct FeedPostListEndpoint: JsonEndpoint {
    
    public typealias Content = [Post]
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "feed")!)
    }
}
