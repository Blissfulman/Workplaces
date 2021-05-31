//
//  LikedPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikedPostListEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = [Post]
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "feed/favorite")!)
    }
}
