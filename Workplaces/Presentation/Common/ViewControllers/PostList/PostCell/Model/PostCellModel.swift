//
//  PostCellModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.05.2021.
//

import Foundation

struct PostCellModel {
    
    // MARK: - Public properties
    
    let post: Post
    
    var location: String? {
        // Нужно будет добавить отображение локации
        guard post.latitude != nil,
              post.longitude != nil else { return nil }
        return "Location is exist" // TEMP
    }
    var isHiddenLocation: Bool {
        location == nil
    }
    var isHiddenPostImage: Bool {
        post.imageURL == nil
    }
    var nickname: String? {
        post.author.nickname
    }
}
