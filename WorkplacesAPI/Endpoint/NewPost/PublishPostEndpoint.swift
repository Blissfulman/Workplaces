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
        let postData = try JSONEncoder.default.encode(post)
        let body = HTTPBody(data: postData, contentType: "multipart/form-data")
        return post(URL(string: "me/posts")!, body: body)
    }
}
