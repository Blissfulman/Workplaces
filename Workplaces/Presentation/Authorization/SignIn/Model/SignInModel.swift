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
    
    var isValidEmail: Bool {
        EmailValidator.isValid(email)
    }
    var isValidPassword: Bool {
        PasswordValidator.isValid(password)
    }
    var isPossibleToSignIn: Bool {
        !isEmptyAtLeastOneProperty
    }
    var userCredentials: UserCredentials {
        UserCredentials(email: email, password: password)
    }
    
    // MARK: - Private properties
    
    private var isEmptyAtLeastOneProperty: Bool {
        if let email = email, !email.isEmpty,
           let password = password, !password.isEmpty {
            return false
        } else {
            return true
        }
    }
}
