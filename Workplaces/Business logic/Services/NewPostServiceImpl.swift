//
//  NewPostServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy

final class NewPostServiceImpl: NewPostService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    
    // MARK: - Initializers
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func publishPost(post: Post) {
        
    }
}
