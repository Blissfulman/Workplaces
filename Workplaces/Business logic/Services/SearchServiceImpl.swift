//
//  SearchServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import Apexy
import WorkplacesAPI

final class SearchServiceImpl: SearchService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    
    // MARK: - Initializers
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func searchUsers(query: String, completion: @escaping UserListResultHandler) -> Progress {
        let endpoint = SearchUserEndpoint(query: query)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
    
    func searchPosts(query: String, completion: @escaping PostListResultHandler) -> Progress {
        let endpoint = SearchPostEndpoint(query: query)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
}
