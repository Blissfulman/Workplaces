//
//  Post.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: String
    let text: String
    let imageURL: URL
    let longitude: Double
    let latitude: Double
    let author: User
    let likes: Int
}
