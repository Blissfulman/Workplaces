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
    
    var isPossibleToSignUp: Bool {
        !isEmptyEmailOrPassword
    }
    var userCredentials: UserCredentials {
        UserCredentials(email: email, password: password)
    }
    var uploadUser: UploadUser {
        UploadUser(
            firstName: firstName ?? "",
            lastName: lastName ?? "",
            nickname: nickname ?? "",
            birthday: birthday ?? Date()
        )
    }
    
    // MARK: - Private properties
    
    private var isEmptyEmailOrPassword: Bool {
        if let email = email, !email.isEmpty,
           let password = password, !password.isEmpty {
            return false
        } else {
            return true
        }
    }
}
