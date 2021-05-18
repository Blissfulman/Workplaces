//
//  SignUpModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.05.2021.
//

import Foundation

final class SignUpModel {
    
    // MARK: - Public properties
    
    var nickname: String?
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var birthday: Date?
    
    var isValidEmail: Bool {
        EmailValidator.isValid(email)
    }
    var isValidPassword: Bool {
        PasswordValidator.isValid(password)
    }
    var userCredentials: UserCredentials {
        UserCredentials(email: email, password: password)
    }
    var updatedProfile: User {
        User(
            id: "",
            firstName: firstName ?? "",
            lastName: lastName ?? "",
            nickname: nickname,
            avatarURL: nil,
            birthday: birthday ?? Date()
        )
    }
}
