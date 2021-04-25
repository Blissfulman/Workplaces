//
//  User.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

public struct User: Identifiable, Codable {
    public let id: String
    let firstName: String
    let lastName: String
    let nickname: String
    let avatarURL: URL
    let birthday: Date
}
