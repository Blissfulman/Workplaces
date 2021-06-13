//
//  AuthorizationServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import Apexy
import WorkplacesAPI

final class AuthorizationServiceImpl: AuthorizationService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    private let securityManager: SecurityManager
    
    // MARK: - Initializers
    
    init(apiClient: Client, securityManager: SecurityManager) {
        self.apiClient = apiClient
        self.securityManager = securityManager
    }
    
    // MARK: - Public methods
    
    func signUpWithEmail(
        userCredentials: UserCredentials,
        completion: @escaping AuthorizationDataResultHandler
    ) -> Progress {
        let endpoint = RegistrationEndpoint(userCredentials: userCredentials)
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
                self?.securityManager.isAuthorized = true
                self?.securityManager.refreshToken = authorizationData.refreshToken
                self?.securityManager.accessToken = authorizationData.accessToken
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(AuthorizationServiceError(error: error.unwrapAFError())))
            }
        }
    }
    
    func signInWithEmail(
        userCredentials: UserCredentials,
        completion: @escaping AuthorizationDataResultHandler
    ) -> Progress {
        let endpoint = LoginEndpoint(userCredentials: userCredentials)
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case let .success(authorizationData):
                self?.securityManager.isAuthorized = true
                self?.securityManager.refreshToken = authorizationData.refreshToken
                self?.securityManager.accessToken = authorizationData.accessToken
                completion(.success(authorizationData))
            case let .failure(error):
                completion(.failure(AuthorizationServiceError(error: error.unwrapAFError())))
            }
        }
    }
    
    func signOut(completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = LogoutEndpoint()
        securityManager.logoutReset()
        return apiClient.request(endpoint) { _ in }
    }
}
