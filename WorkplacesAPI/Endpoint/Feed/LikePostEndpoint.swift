//
//  LikePostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikePostEndpoint: EmptyEndpoint {
    
    private let postID: String
    
    public init(postID: String) {
        self.postID = postID
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "feed/\(postID)/like")!, body: nil)
    }
}
