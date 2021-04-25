//
//  User.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let nickname: String
    let avatarURL: URL
    let birthday: Date
}

// TEMP
struct CredentialData {
    let email: String?
    let password: String?
}
