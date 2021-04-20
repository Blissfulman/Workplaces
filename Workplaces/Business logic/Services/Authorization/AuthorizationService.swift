//
//  AuthorizationService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import FirebaseAuth

// MARK: - Protocols

protocol AuthorizationServiceProtocol {
    /// Регистрация нового пользоваталя.
    /// - Parameters:
    ///   - email: E-mail пользователя.
    ///   - password: Пароль пользователя.
    ///   - completion: Замыкание, в которое возвращается результат выполнения запроса.
    func registerUser(withEmail email: String,
                      andPassword password: String,
                      completion: @escaping (Result<Bool, Error>) -> Void)
    
    /// Авторизация зарегистрированного пользователя.
    /// - Parameters:
    ///   - email: E-mail пользователя.
    ///   - password: Пароль пользователя.
    ///   - completion: Замыкание, в которое возвращается результат выполнения запроса.
    func signIn(withEmail email: String,
                andPassword password: String,
                completion: @escaping (Result<Bool, Error>) -> Void)
    
    /// Разавторизация пользователя.
    /// - Parameter errorHandler: Обработчик ошибки выполнения запроса.
    func signOut(errorHandler: @escaping (Error) -> Void)
}

final class AuthorizationService: AuthorizationServiceProtocol {
    
    // MARK: - Public methods
    
    func registerUser(withEmail email: String,
                      andPassword password: String,
                      completion: @escaping (Result<Bool, Error>) -> Void) {
        LoadingView.show()
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            LoadingView.hide()
            
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func signIn(withEmail email: String,
                andPassword password: String,
                completion: @escaping (Result<Bool, Error>) -> Void) {
        LoadingView.show()
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            LoadingView.hide()
            
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func signOut(errorHandler: @escaping (Error) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            errorHandler(error)
        }
    }
}
