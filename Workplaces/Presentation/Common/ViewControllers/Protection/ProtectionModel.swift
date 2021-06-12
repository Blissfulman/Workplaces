//
//  ProtectionModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

final class ProtectionModel {
    
    // MARK: - Public properties
    
    let isSetProtection: Bool
    var password = ""
    var screenMessage: String {
        isSetProtection
            ? "Enter your password".localized()
            : "Set a four-digit password to protect the enter to app".localized()
    }
    var passwordErrorMessage: String {
        remainingEntryAttemptsCount > 0
            ? "Try again. ".localized() + "Attempts remaining: ".localized() + "\(remainingEntryAttemptsCount)"
            : "You have used up all password attempts. You will be logged out.".localized()
    }
    var isNeedLogOut: Bool {
        remainingEntryAttemptsCount < 1
    }
    var remainingEntryAttemptsCount = 0
    
    // MARK: - Initializers
    
    init(isSetProtection: Bool) {
        self.isSetProtection = isSetProtection
    }
}
