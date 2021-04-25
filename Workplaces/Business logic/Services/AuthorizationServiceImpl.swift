//
//  AuthorizationServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import Apexy

final class AuthorizationServiceImpl: AuthorizationService {
    
    // MARK: - Private properties
    
    private let apiClient: Client
    private let settingsStorage: SettingsStorage
    
    // MARK: - Initializers
    
    init(apiClient: Client, settingsStorage: SettingsStorage) {
        self.apiClient = apiClient
        self.settingsStorage = settingsStorage
    }
    
    // MARK: - Public methods
    
    func registerUser(withEmail email: String, andPassword password: String, completion: @escaping VoidResultHandler) {
        let result = Bool.random()
        settingsStorage.saveAuthState(to: result)
        result
            ? completion(.success(()))
            : completion(.failure(TestError.unknownError))
    }
    
    func signIn(withEmail email: String, andPassword password: String, completion: @escaping VoidResultHandler) {
        let result = Bool.random()
        settingsStorage.saveAuthState(to: result)
        result
            ? completion(.success(()))
            : completion(.failure(TestError.credentialError))
    }
    
    func signInByGoogle() {
        
    }
    
    func signInByFacebook() {
        
    }
    
    func signInByVK() {
        
    }
    
    func signOut() {
        settingsStorage.saveAuthState(to: false)
    }
    
    func refreshToken() {
        
    }
}
