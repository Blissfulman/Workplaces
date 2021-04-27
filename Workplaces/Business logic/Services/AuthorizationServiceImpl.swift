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
    
    // MARK: - Initializers
    
    init(apiClient: Client, authDataStorage: AuthDataStorage) {
        self.apiClient = apiClient
        self.authDataStorage = authDataStorage
    }
    
    // MARK: - Public methods
    
    func registerUser(
        userCredentials: UserCredentials,
        completion: @escaping AuthorizationDataResultHandler
    ) -> Progress {
        let endpoint = RegistrationEndpoint(userCredentials: userCredentials)
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
    
    func signIn(userCredentials: UserCredentials, completion: @escaping AuthorizationDataResultHandler) -> Progress {
        let endpoint = LoginEndpoint(userCredentials: userCredentials)
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
    
    func signInByGoogle() {
        
    }
    
    func signInByFacebook() {
        
    }
    
    func signInByVK() {
        
    }
    
    func signOut(completion: @escaping VoidResultHandler) -> Progress {
        let endpoint = LogoutEndpoint()
        return apiClient.request(endpoint) { [weak self] result in
            switch result {
            case .success:
                self?.authDataStorage.deleteAuthData()
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func refreshToken(completion: @escaping AuthorizationDataResultHandler) -> Progress {
        let endpoint = RefreshTokenEndpoint(refreshToken: authDataStorage.getRefreshToken())
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
