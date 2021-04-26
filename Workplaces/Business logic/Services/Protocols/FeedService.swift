//
//  FeedService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import WorkplacesAPI

protocol FeedService {
    
    typealias Post = WorkplacesAPI.Post
    typealias PostListResultHandler = ResultHandler<[Post]>
    
    /// Получение постов ленты.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func fetchFeedPosts(completion: @escaping PostListResultHandler) -> Progress
    
    /// Добавление лайка к посту.
    /// - Parameters:
    ///   - postID: ID поста.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func likePost(postID: String, completion: @escaping VoidResultHandler) -> Progress
    
    /// Удаление лайка с поста.
    /// - Parameters:
    ///   - postID: ID поста.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func unlikePost(postID: String, completion: @escaping VoidResultHandler) -> Progress
}
