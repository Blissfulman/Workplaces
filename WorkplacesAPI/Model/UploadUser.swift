//
//  UploadUser.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

public struct UploadUser: Encodable {
    
    let firstName: String
    let lastName: String
    let nickname: String
    let avatarFile: String
    let birthday: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case nickname
        case avatarFile
        case birthday = "birthDay"
    }
    
    init(user: User) {
        firstName = user.firstName
        lastName = user.lastName
        nickname = user.nickname ?? ""
        if let url = user.avatarURL,
           let avatarData = try? Data(contentsOf: url) {
            avatarFile = String(data: avatarData, encoding: .utf8) ?? ""
        } else {
            avatarFile = ""
        }
        birthday = String(describing: user.birthday)
    }
}
