//
//  ProfileService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol ProfileService {
    
    typealias UserResultHandler = ResultHandler<User>
    typealias UserListResultHandler = ResultHandler<[User]>
    typealias PostListResultHandler = ResultHandler<[Post]>
    
    /// Получение своего профиля.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func fetchMyProfile(completion: @escaping UserResultHandler) -> Progress
    
    /// Обновление своего профиля.
    /// - Parameters:
    ///   - user: Профиль.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func updateMyProfile(user: User, completion: @escaping UserResultHandler) -> Progress
    
    /// Получение своих постов.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func fetchMyPosts(completion: @escaping PostListResultHandler) -> Progress
    
    /// Получение лайкнутых постов.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func fetchLikedPosts(completion: @escaping PostListResultHandler) -> Progress
    
    /// Получение списка друзей.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func fetchFriends(completion: @escaping UserListResultHandler) -> Progress
    
    /// Добавление пользователя в список друзей.
    /// - Parameters:
    ///   - userID: ID пользователя.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func addFriend(userID: User.ID, completion: @escaping VoidResultHandler) -> Progress
    
    /// Удаление пользователя из списка друзей.
    /// - Parameters:
    ///   - userID: ID пользователя.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func removeFriend(userID: User.ID, completion: @escaping VoidResultHandler) -> Progress
}
