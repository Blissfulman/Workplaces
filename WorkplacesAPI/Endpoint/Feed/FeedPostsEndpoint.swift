//
//  FeedPostsEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy

public struct FeedPostsEndpoint: Endpoint, URLRequestBuildable {
    
    public typealias Content = [Post]

    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        return get(URL(string: "feed")!)
    }

    public func content(from response: URLResponse?, with body: Data) throws -> [Post] {
        []
    }
}
