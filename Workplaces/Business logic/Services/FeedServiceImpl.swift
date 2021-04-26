//
//  FeedServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy
import WorkplacesAPI

final class FeedServiceImpl: FeedService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    
    // MARK: - Initializers
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func fetchFeedPosts(completion: @escaping PostsResultHandler) -> Progress {
        let endpoint = FeedPostsEndpoint()
        return apiClient.request(endpoint, completionHandler: completion)
    }
    
    func likePost(postID: String, completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = LikePostEndpoint(postID: postID)
        return apiClient.request(endpoint, completionHandler: completion)
    }
    
    func unlikePost(postID: String, completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = UnlikePostEndpoint(postID: postID)
        return apiClient.request(endpoint, completionHandler: completion)
    }
}
