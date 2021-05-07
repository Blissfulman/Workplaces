//
//  AuthorizationService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol AuthorizationService {
    
    typealias AuthorizationDataResultHandler = ResultHandler<AuthorizationData>
    
    /// Регистрация нового пользоваталя.
    /// - Parameters:
    ///   - userCredentials: Учётные данные для регистрации.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func signUpWithEmail(
        userCredentials: UserCredentials,
        completion: @escaping AuthorizationDataResultHandler
    ) -> Progress
    
    /// Авторизация зарегистрированного пользователя.
    /// - Parameters:
    ///   - userCredentials: Учётные данные пользователя.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func signInWithEmail(
        userCredentials: UserCredentials,
        completion: @escaping AuthorizationDataResultHandler
    ) -> Progress
    
    /// Авторизация с помощью аккаунта Google.
    func signInWithGoogle()
    
    /// Авторизация с помощью аккаунта Facebook.
    func signInWithFacebook()
    
    /// Авторизация с помощью аккаунта VK.
    func signInWithVK()
    
    /// Завершение сессии пользователя.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func signOut(completion: @escaping VoidResultHandler) -> Progress
}
