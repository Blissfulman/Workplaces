//
//  UploadUser.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import Foundation

public struct UploadUser {
    
    // MARK: - Public properties
    
    let firstName: String
    let lastName: String
    let nickname: String
    let birthday: String
    let avatarFileURL: URL?
    
    // MARK: - Initializers
    
    public init(firstName: String, lastName: String, nickname: String, birthday: Date, avatarFileURL: URL? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.nickname = nickname
        self.birthday = DateFormatter.uploadDateFormatter.string(from: birthday)
        self.avatarFileURL = avatarFileURL
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
