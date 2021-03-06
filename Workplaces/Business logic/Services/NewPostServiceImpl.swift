//
//  NewPostServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Apexy
import WorkplacesAPI

final class NewPostServiceImpl: NewPostService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    
    // MARK: - Initializers
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func publishPost(uploadPost: UploadPost, completion: @escaping PostResultHandler) -> Progress {
        let endpoint = PublishPostEndpoint(uploadPost: uploadPost)
        return apiClient.request(endpoint) { result in
            completion(result.mapError { $0.unwrapAFError() })
        }
    }
}
