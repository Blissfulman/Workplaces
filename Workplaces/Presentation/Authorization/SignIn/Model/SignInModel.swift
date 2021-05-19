//
//  SignInModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 14.05.2021.
//

final class SignInModel {
    
    // MARK: - Public properties
    
    var email: String?
    var password: String?
    
    var isPossibleToSignIn: Bool {
        !isEmptyEmailOrPassword
    }
    var userCredentials: UserCredentials {
        UserCredentials(email: email, password: password)
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
