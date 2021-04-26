//
//  LikePostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikePostEndpoint: EmptyEndpoint {
    
    private let postID: Post.ID
    private let token = ""
    
    public init(postID: Post.ID) {
        self.postID = postID
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = post(URL(string: "feed/\(postID)/like")!, body: nil)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
