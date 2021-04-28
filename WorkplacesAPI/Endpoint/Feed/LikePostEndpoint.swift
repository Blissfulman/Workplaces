//
//  LikePostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikePostEndpoint: EmptyEndpoint {
    
    private let postID: Post.ID
    
    public init(postID: Post.ID) {
        self.postID = postID
    }
    
    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "feed")!
            .appendingPathComponent(postID)
            .appendingPathComponent("like")
        return post(url, body: nil)
    }
}
