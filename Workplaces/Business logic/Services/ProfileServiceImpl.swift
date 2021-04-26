//
//  ProfileServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy
import WorkplacesAPI

final class ProfileServiceImpl: ProfileService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    
    // MARK: - Initializers
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func fetchMyProfile(completion: @escaping UserResultHandler) {
        
    }
    
    func updateMyProfile(user: User, completion: @escaping UserResultHandler) {
        
    }
    
    func fetchMyPosts(completion: @escaping PostListResultHandler) {
        
    }
    
    func fetchLikedPosts(completion: @escaping PostListResultHandler) -> Progress {
        let endpoint = LikedPostListEndpoint()
        return apiClient.request(endpoint, completionHandler: completion)
    }
    
    func fetchFriendList(completion: @escaping UserListResultHandler) {
        
    }
    
    func addFriend(userID: String) {
        
    }
    
    func removeFriend(userID: String) {
        
    }
}
