//
//  PublishPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct PublishPostEndpoint: JsonEndpoint {
    
    public typealias Content = Post
    
    let post: Post
    
    public init(post: Post) {
        self.post = post
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "me/posts")!, body: .json(try JSONEncoder.default.encode(post)))
    }
}
