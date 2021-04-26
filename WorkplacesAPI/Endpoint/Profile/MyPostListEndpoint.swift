//
//  MyPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct MyPostListEndpoint: JsonEndpoint {
    
    public typealias Content = [Post]
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "me/posts")!)
    }
}
