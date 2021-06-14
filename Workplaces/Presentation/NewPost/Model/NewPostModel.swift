//
//  NewPostModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.06.2021.
//

import Foundation

final class NewPostModel {
    
    // MARK: - Public properties
    
    var text = ""
    var imageURL: URL?
    var isPossibleToPublishPost: Bool {
        !text.isEmpty
    }
    var uploadPost: UploadPost {
        // Временно передаю захардкоженные данные. Нужно будет доработать.
        let location = UploadPost.Location(longitude: 10.3, latitude: 20.6)
        return UploadPost(text: text, imageURL: imageURL, location: location)
    }
}
