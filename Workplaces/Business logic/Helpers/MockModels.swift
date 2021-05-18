//
//  MockModels.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 11.05.2021.
//

import Foundation

extension User {
    
    static func getMockUsers() -> [Self] {
        let user = User(
            id: "8feed535-5ca5-464e-862d-0de124800aa3",
            firstName: "Nick",
            lastName: "Andersen",
            nickname: "tiger",
            avatarURL: URL(string: "https://about.gitlab.com/images/press/logo/jpg/gitlab-icon-rgb.jpg")!,
            birthday: Date()
        )
        return Array(repeating: user, count: 10)
    }
}

extension Post {
    
    static func getMockPosts() -> [Self] {
        let author = User(
            id: "8feed535-5ca5-464e-862d-0de124800aa3",
            firstName: "Nick",
            lastName: "Andersen",
            nickname: "tiger",
            avatarURL: URL(string: "https://about.gitlab.com/images/press/logo/jpg/gitlab-icon-rgb.jpg")!,
            birthday: Date()
        )
        let post = Post(
            id: "8feed535-5ca5-464e-862d-0de124800aa3",
            text: "Soprano, we like to keep it on a high note. It's levels to it, you and I know",
            imageURL: URL(string: "https://about.gitlab.com/images/press/logo/jpg/gitlab-icon-rgb.jpg")!,
            longitude: 31.9998,
            latitude: 36.5438,
            author: author,
            likes: 5,
            liked: true
        )
        return Array(repeating: post, count: 10)
    }
}
