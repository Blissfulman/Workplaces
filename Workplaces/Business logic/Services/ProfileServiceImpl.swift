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
    
    func fetchMyProfile(completion: @escaping UserResultHandler) -> Progress {
        let endpoint = MyProfileEndpoint()
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func updateMyProfile(user: User, completion: @escaping UserResultHandler) -> Progress {
        let endpoint = UpdatingMyProfileEndpoint(user: user)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func fetchMyPosts(completion: @escaping PostListResultHandler) -> Progress {
        let endpoint = MyPostListEndpoint()
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func fetchLikedPosts(completion: @escaping PostListResultHandler) -> Progress {
        let endpoint = LikedPostListEndpoint()
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func fetchFriendList(completion: @escaping UserListResultHandler) -> Progress {
        let endpoint = FriendListEndpoint()
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func addFriend(userID: User.ID, completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = AddFriendEndpoint(userID: userID)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func removeFriend(userID: User.ID, completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = RemoveFriendEndpoint(userID: userID)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
}
