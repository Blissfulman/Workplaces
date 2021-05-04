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
    private let authDataStorage: AuthDataStorage
    
    // MARK: - Initializers
    
    public init(apiClient: Client, authDataStorage: AuthDataStorage) {
        self.apiClient = apiClient
        self.authDataStorage = authDataStorage
    }
    
    // MARK: - Public methods
    
    public func refreshToken(completion: @escaping ResultHandler<AuthorizationData>) -> Progress {
        let endpoint = RefreshTokenEndpoint(refreshToken: authDataStorage.refreshToken ?? "")
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
                self?.authDataStorage.saveAuthData(authorizationData)
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
