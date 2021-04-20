//
//  AuthorizationService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import FirebaseAuth

protocol AuthorizationServiceProtocol {
    func registerUser(withEmail email: String,
                      andPassword password: String,
                      completion: @escaping (Result<Bool, Error>) -> Void)
    func sisnIn(withEmail email: String,
                andPassword password: String,
                completion: @escaping (Result<Bool, Error>) -> Void)
    func signOut()
}

final class AuthorizationService: AuthorizationServiceProtocol {
    
    // MARK: - Public methods
    
    func registerUser(withEmail email: String,
                      andPassword password: String,
                      completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func sisnIn(withEmail email: String,
                andPassword password: String,
                completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
