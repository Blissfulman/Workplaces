//
//  Post.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

public struct Post: Identifiable, Codable {
    
    public let id: String
    let text: String?
    let imageURL: URL?
    let longitude: Double?
    let latitude: Double?
    let author: User
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case imageURL = "image_url"
        case longitude = "lon"
        case latitude = "lat"
        case author
        case likes
    }
}
