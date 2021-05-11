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
    
    func fetchFeedPosts(completion: @escaping PostListResultHandler) -> Progress {
        let endpoint = FeedPostListEndpoint()
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func likePost(postID: Post.ID, completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = LikePostEndpoint(postID: postID)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func unlikePost(postID: Post.ID, completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = UnlikePostEndpoint(postID: postID)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
}
