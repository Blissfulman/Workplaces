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
    
    func searchUser(query: String, completion: @escaping UserResultHandler) -> Progress {
        Progress()
    }
    
    func searchPost(query: String, completion: @escaping PostResultHandler) -> Progress {
        Progress()
    }
}
