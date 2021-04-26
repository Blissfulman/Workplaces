//
//  NewPostService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import WorkplacesAPI

protocol NewPostService {
    
    typealias Post = WorkplacesAPI.Post
    typealias PostResultHandler = ResultHandler<Post>
    
    /// Публикация нового поста.
    /// - Parameters:
    ///   - post: Публикуемый пост.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func publishPost(post: Post, completion: @escaping PostResultHandler) -> Progress
}
