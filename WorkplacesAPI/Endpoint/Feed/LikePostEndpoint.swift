//
//  LikePostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikePostEndpoint: EmptyEndpoint {
    
    let postID: String
    
    public init(postID: String) {
        self.postID = postID
    }
    
    public func makeRequest() throws -> URLRequest {
        post(URL(string: "\(postID)/like")!, body: nil)
    }
}
