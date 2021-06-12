//
//  TokenRefreshService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 01.05.2021.
//

import Apexy
import WorkplacesAPI

final class TokenRefreshServiceImpl: TokenRefreshService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    private let securityManager: SecurityManager
    
    // MARK: - Initializers
    
    init(apiClient: Client, securityManager: SecurityManager) {
        self.apiClient = apiClient
        self.securityManager = securityManager
    }
    
    // MARK: - Public methods
    
    func refreshTokens(completion: @escaping ResultHandler<AuthorizationData>) -> Progress {
        let endpoint = RefreshTokenEndpoint(refreshToken: securityManager.refreshToken ?? "")
        
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
                self?.saveTokens(authorizationData: authorizationData)
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func saveTokens(authorizationData: AuthorizationData) {
        securityManager.refreshToken = authorizationData.refreshToken
        securityManager.accessToken = authorizationData.accessToken
        _ = securityManager.saveRefreshTokenWithPassword(
            token: authorizationData.refreshToken,
            password: securityManager.password
        )
    }
}
