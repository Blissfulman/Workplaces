//
//  UploadUser.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import UIKit

public struct UploadUser: Encodable {
    
    // MARK: - Nested types
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case nickname
        case avatarFile
        case birthday = "birthDay"
    }
    
    // MARK: - Public properties
    
    let firstName: String
    let lastName: String
    let nickname: String
    let avatarFile: String
    let birthday: String
    
    // MARK: - Initializers
    
    // Временный инициализатор
    init(user: User) {
        firstName = user.firstName
        lastName = user.lastName
        nickname = user.nickname ?? ""
        if let url = user.avatarURL,
           let imageData = try? Data(contentsOf: url),
           let jpegData = UIImage(data: imageData)?.jpegData(compressionQuality: 1) {
            avatarFile = jpegData.base64EncodedString()
        } else {
            avatarFile = ""
        }
        birthday = DateFormatter.uploadDateFormatter.string(from: user.birthday)
    }
}

// MARK: - Extensions

fileprivate extension DateFormatter {
    
    static let uploadDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
