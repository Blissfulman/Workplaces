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
    private let securityManager: SecurityManager
    
    // MARK: - Initializers
    
    public init(apiClient: Client, securityManager: SecurityManager) {
        self.apiClient = apiClient
        self.securityManager = securityManager
    }
    
    // MARK: - Public methods
    
    public func refreshToken(completion: @escaping ResultHandler<AuthorizationData>) -> Progress {
//        let endpoint = RefreshTokenEndpoint(refreshToken: securityManager.refreshToken ?? "")
        let endpoint = RefreshTokenEndpoint(refreshToken: securityManager.temporaryRefreshToken ?? "")
        
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
//                self?.securityManager.refreshToken = authorizationData.refreshToken
                self?.securityManager.accessToken = authorizationData.accessToken
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
