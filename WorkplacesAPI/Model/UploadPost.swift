//
//  UploadPost.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import UIKit

public struct UploadPost: Encodable {
    
    // MARK: - Nested types
    
    private enum CodingKeys: String, CodingKey {
        case text
        case imageFile
        case longitude = "lon"
        case latitude = "lat"
    }
    
    // MARK: - Public properties
    
    let text: String
    let imageFile: String
    let longitude: String
    let latitude: String
    
    // MARK: - Initializers
    
    // Временный инициализатор
    init(post: Post) {
        text = post.text ?? ""
        if let url = post.imageURL,
           let imageData = try? Data(contentsOf: url),
           let base64Data = UIImage(data: imageData)?.pngData()?.base64EncodedData(),
           let stringData = String(data: base64Data, encoding: .utf8) {
            imageFile = stringData
        } else {
            imageFile = ""
        }
        longitude = String(describing: post.longitude ?? 0)
        latitude = String(describing: post.latitude ?? 0)
    }
}
