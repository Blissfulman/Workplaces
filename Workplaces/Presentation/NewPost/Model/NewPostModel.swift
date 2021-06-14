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
    var imageData: Data?
    var isPossibleToPublishPost: Bool {
        !text.isEmpty
    }
    var post: UploadPost {
        let location = UploadPost.Location(longitude: 0, latitude: 0)
        return UploadPost(text: text, imageData: imageData, location: location)
    }
}
