//
//  PublishPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct PublishPostEndpoint: JsonEndpoint {
    
    public typealias Content = Post
    
    private let uploadPost: UploadPost
    
    public init(post: Post) {
        self.uploadPost = UploadPost(post: post)
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "me/posts")!, body: .multipart(try encoder.encode(uploadPost)))
    }
}
