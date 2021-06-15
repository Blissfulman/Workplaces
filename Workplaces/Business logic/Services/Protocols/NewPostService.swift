//
//  NewPostService.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

protocol NewPostService {
    
    typealias PostResultHandler = ResultHandler<Post>
    
    /// Публикация нового поста.
    /// - Parameters:
    ///   - uploadPost: Публикуемый пост.
    ///   - completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func publishPost(uploadPost: UploadPost, completion: @escaping PostResultHandler) -> Progress
}
