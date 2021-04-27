//
//  AuthorizationService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation
import WorkplacesAPI

protocol AuthorizationService {
    
    typealias AuthorizationDataResultHandler = ResultHandler<AuthorizationData>
    
    /// Регистрация нового пользоваталя.
    /// - Parameters:
    ///   - credentialData: Учётные данные для регистрации.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func registerUser(credentialData: CredentialData, completion: @escaping AuthorizationDataResultHandler) -> Progress
    
    /// Авторизация зарегистрированного пользователя.
    /// - Parameters:
    ///   - credentialData: Учётные данные пользователя.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func signIn(credentialData: CredentialData, completion: @escaping AuthorizationDataResultHandler) -> Progress
    
    /// Авторизация с помощью аккаунта Google.
    func signInByGoogle()
    
    /// Авторизация с помощью аккаунта Facebook.
    func signInByFacebook()
    
    /// Авторизация с помощью аккаунта VK.
    func signInByVK()
    
    /// Завершение сессии пользователя.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func signOut(completion: @escaping VoidResultHandler) -> Progress
    
    /// Обновление токена доступа.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func refreshToken(completion: @escaping AuthorizationDataResultHandler) -> Progress
}
