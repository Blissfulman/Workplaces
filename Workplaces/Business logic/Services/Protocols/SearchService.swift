//
//  SearchService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import Foundation

protocol SearchService {
    
    typealias UserListResultHandler = ResultHandler<[User]>
    typealias PostListResultHandler = ResultHandler<[Post]>
    
    /// Поиск пользователей по поисковому запросу (поиск производится в именах, фамилиях и никах пользователей).
    /// - Parameters:
    ///   - query: Искомый текстовый фрагмент.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func searchUsers(query: String, completion: @escaping UserListResultHandler) -> Progress
    
    /// Поиск постов по поисковому запросу (поиск производится в тексте постов).
    /// - Parameters:
    ///   - query: Искомый текстовый фрагмент.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func searchPosts(query: String, completion: @escaping PostListResultHandler) -> Progress
}
