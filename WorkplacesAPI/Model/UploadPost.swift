//
//  UploadPost.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

public struct UploadPost: Encodable {
    
    let text: String
    let imageFile: String
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case text
        case imageFile
        case longitude = "lon"
        case latitude = "lat"
    }
    
    init(post: Post) {
        text = post.text ?? ""
        if let url = post.imageURL,
           let imageData = try? Data(contentsOf: url) {
            imageFile = String(data: imageData, encoding: .utf8) ?? ""
        } else {
            imageFile = ""
        }
        longitude = post.longitude ?? 0
        latitude = post.latitude ?? 0
    }
}
