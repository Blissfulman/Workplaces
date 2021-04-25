//
//  Post.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

public struct Post: Identifiable, Codable {
    public let id: String
    let text: String
    let imageURL: URL
    let longitude: Double
    let latitude: Double
    let author: User
    let likes: Int
}
