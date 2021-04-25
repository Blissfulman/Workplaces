//
//  FeedServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy

final class FeedServiceImpl: FeedService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    
    // MARK: - Initializers
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func fetchFeedPosts(completion: @escaping PostsResultHandler) {
        
    }
    
    func likePost() {
        
    }
    
    func unlikePost() {
        
    }
}
