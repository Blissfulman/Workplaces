//
//  AuthorizationService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol AuthorizationService {
    
    typealias VoidResultHandler = ResultHandler<Void>
    
    /// Регистрация нового пользоваталя.
    /// - Parameters:
    ///   - email: E-mail пользователя.
    ///   - password: Пароль пользователя.
    ///   - completion: Замыкание, в которое возвращается результат выполнения запроса.
    func registerUser(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping VoidResultHandler
    )
    
    /// Авторизация зарегистрированного пользователя.
    /// - Parameters:
    ///   - email: E-mail пользователя.
    ///   - password: Пароль пользователя.
    ///   - completion: Замыкание, в которое возвращается результат выполнения запроса.
    func signIn(
        withEmail email: String,
        andPassword password: String,
        completion: @escaping VoidResultHandler
    )
    
    /// Авторизация с помощью аккаунта Google.
    func signInByGoogle()
    
    /// Авторизация с помощью аккаунта Facebook.
    func signInByFacebook()
    
    /// Авторизация с помощью аккаунта VK.
    func signInByVK()
    
    /// Завершение сессии пользователя.
    func signOut()
    
    /// Обновление токена доступа.
    func refreshToken()
}
