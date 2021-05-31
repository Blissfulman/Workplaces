//
//  UnlikePostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct UnlikePostEndpoint: EmptyEndpoint {
    
    // MARK: - Private properties
    
    private let postID: Post.ID
    
    // MARK: - Initializers
    
    public init(postID: Post.ID) {
        self.postID = postID
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        let url = URL(string: "feed")!
            .appendingPathComponent(postID)
            .appendingPathComponent("like")
        return delete(url)
    }
}
