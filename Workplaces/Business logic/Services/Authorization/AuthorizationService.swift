//
//  AuthorizationService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import Foundation

// MARK: - Protocols

protocol AuthorizationService {
    /// Регистрация нового пользоваталя.
    /// - Parameters:
    ///   - email: E-mail пользователя.
    ///   - password: Пароль пользователя.
    ///   - completion: Замыкание, в которое возвращается результат выполнения запроса.
    func registerUser(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
    /// Авторизация зарегистрированного пользователя.
    /// - Parameters:
    ///   - email: E-mail пользователя.
    ///   - password: Пароль пользователя.
    ///   - completion: Замыкание, в которое возвращается результат выполнения запроса.
    func signIn(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
    /// Авторизация с помощью аккаунта Google.
    func signInByGoogle()
    
    /// Авторизация с помощью аккаунта Facebook.
    func signInByFacebook()
    
    /// Авторизация с помощью аккаунта VK.
    func signInByVK()
    
    /// Разавторизация пользователя.
    /// - Parameter errorHandler: Обработчик ошибки выполнения запроса.
    func signOut()
}

final class AuthorizationServiceImpl: AuthorizationService {
    
    // MARK: - Public methods
    
    func registerUser(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Bool.random() ? completion(.success(())) : completion(.failure(TestError.unknownError))
    }
    
    func signIn(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping (Result<Void, Error>) -> Void
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
}
