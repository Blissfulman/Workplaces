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
    private let authDataStorage: AuthDataStorage
    private let settingsStorage: SettingsStorage
    
    // MARK: - Initializers
    
    init(apiClient: Client, authDataStorage: AuthDataStorage, settingsStorage: SettingsStorage) {
        self.apiClient = apiClient
        self.authDataStorage = authDataStorage
        self.settingsStorage = settingsStorage
    }
    
    // MARK: - Public methods
    
    func registerUser(
        credentialData: CredentialData,
        completion: @escaping AuthorizationDataResultHandler
    ) -> Progress {
        let endpoint = RegistrationEndpoint(credentialData: credentialData)
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
    
    func signIn(credentialData: CredentialData, completion: @escaping AuthorizationDataResultHandler) -> Progress {
        let endpoint = LoginEndpoint(credentialData: credentialData)
        return apiClient.request(endpoint, completionHandler: completion)
    }
    
    func signInByGoogle() {
        
    }
    
    func signInByFacebook() {
        
    }
    
    func signInByVK() {
        
    }
    
    func signOut(completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = LogoutEndpoint()
        return apiClient.request(endpoint, completionHandler: completion)
    }
    
    func refreshToken(completion: @escaping AuthorizationDataResultHandler) -> Progress {
        let endpoint = RefreshTokenEndpoint(refreshToken: authDataStorage.getRefreshToken())
        return apiClient.request(endpoint, completionHandler: completion)
    }
}
