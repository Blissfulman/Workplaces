//
//  FeedPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy

public struct FeedPostListEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = [Post]
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "feed")!)
    }
}
