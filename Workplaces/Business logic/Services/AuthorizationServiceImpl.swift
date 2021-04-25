//
//  AuthorizationServiceImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import Foundation

final class AuthorizationServiceImpl: AuthorizationService {
    
    // MARK: - Public methods
    
    func registerUser(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping VoidResultHandler
    ) {
        Bool.random() ? completion(.success(())) : completion(.failure(TestError.unknownError))
    }
    
    func signIn(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping VoidResultHandler
    ) {
        Bool.random() ? completion(.success(())) : completion(.failure(TestError.credentialError))
    }
    
    func signInByGoogle() {
        
    }
    
    func signInByFacebook() {
        
    }
    
    func signInByVK() {
        
    }
    
    func signOut() {
        
    }
    
    func refreshToken() {
        
    }
}
