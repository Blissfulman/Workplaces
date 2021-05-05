//
//  StringValidator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import Foundation

enum StringValidator {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
