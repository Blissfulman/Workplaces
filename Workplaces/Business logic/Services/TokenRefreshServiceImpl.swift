//
//  TokenRefreshService.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.05.2021.
//

import Apexy
import WorkplacesAPI

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
    
    public func refreshTokens(completion: @escaping ResultHandler<AuthorizationData>) -> Progress {
        let endpoint = RefreshTokenEndpoint(refreshToken: securityManager.refreshToken ?? "")
        
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
                self?.securityManager.refreshToken = authorizationData.refreshToken
                self?.securityManager.accessToken = authorizationData.accessToken
                self?.saveToStoreRefreshToken(authorizationData.refreshToken)
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func saveToStoreRefreshToken(_ token: String) {
        if securityManager.protectionState == .passwordProtected {
            _ = securityManager.saveRefreshTokenWithPassword(token: token, password: securityManager.password)
        }
        if securityManager.protectionState == .passwordProtected {
            // Доработать сохранение с помощью биометрии
        }
    }
}
