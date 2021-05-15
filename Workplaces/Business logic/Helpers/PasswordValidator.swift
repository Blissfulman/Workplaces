//
//  PasswordValidator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 15.05.2021.
//

import Foundation

enum PasswordValidator {
    
    static func isValid(_ password: String?) -> Bool {
        guard let password = password, password.count > 7 else { return false }
        
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }
}
