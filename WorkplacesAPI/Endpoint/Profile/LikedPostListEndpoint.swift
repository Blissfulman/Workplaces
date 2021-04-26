//
//  LikedPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikedPostListEndpoint: JsonEndpoint {
    
    public typealias Content = [Post]
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "feed/favorite")!)
    }
}
