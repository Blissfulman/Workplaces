//
//  EmailValidator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import Foundation

enum EmailValidator {
    
    static func isValid(_ email: String?) -> Bool {
        guard let email = email, email.count > 5 else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
