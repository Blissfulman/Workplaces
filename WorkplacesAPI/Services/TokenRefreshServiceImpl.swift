//
//  TokenRefreshService.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.05.2021.
//

import Apexy

public final class TokenRefreshServiceImpl: TokenRefreshService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    private let tokenStorage: TokenStorage
    
    // MARK: - Initializers
    
    public init(apiClient: Client, tokenStorage: TokenStorage) {
        self.apiClient = apiClient
        self.tokenStorage = tokenStorage
    }
    
    // MARK: - Public methods
    
    public func refreshToken(completion: @escaping ResultHandler<AuthorizationData>) -> Progress {
        let endpoint = RefreshTokenEndpoint(refreshToken: tokenStorage.refreshToken ?? "")
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
                self?.tokenStorage.refreshToken = authorizationData.refreshToken
                self?.tokenStorage.accessToken = authorizationData.accessToken
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
