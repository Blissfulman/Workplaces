//
//  SearchService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import Foundation

protocol SearchService {
    
    typealias UserResultHandler = ResultHandler<User>
    typealias PostResultHandler = ResultHandler<Post>
    
    /// Поиск пользователя по части имени, фамилии или ника.
    /// - Parameters:
    ///   - query: Искомый текстовый фрагмент.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func searchUser(query: String, completion: @escaping UserResultHandler) -> Progress
    
    /// Поиск публикации по части текста.
    /// - Parameters:
    ///   - query: Искомый текстовый фрагмент.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func searchPost(query: String, completion: @escaping PostResultHandler) -> Progress
}
