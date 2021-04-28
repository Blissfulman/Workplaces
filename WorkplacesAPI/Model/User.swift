//
//  User.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

public struct User: Identifiable, Codable {
    
    public let id: String
    let firstName: String
    let lastName: String
    let nickname: String?
    let avatarURL: URL?
    let birthday: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case nickname
        case avatarURL = "avatarUrl"
        case birthday = "birthDay"
    }
    
    public init(id: String, firstName: String, lastName: String, nickname: String?, avatarURL: URL?, birthday: Date) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.nickname = nickname
        self.avatarURL = avatarURL
        self.birthday = birthday
    }
}

public extension User {
    
    /// Возвращает экземпляр `User` для тестов.
    static func testUser() -> Self {
        User(
            id: "test",
            firstName: "test",
            lastName: "test",
            nickname: "test",
            avatarURL: URL(string: "https://redmadrobot.com/")!,
            birthday: Date()
        )
    }
}
