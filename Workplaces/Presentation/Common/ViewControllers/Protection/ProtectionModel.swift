//
//  ProtectionModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

final class ProtectionModel {
    
    // MARK: - Nested types
    
    enum State {
        case protectionInstalled
        case protectionNotInstalled
    }
    
    // MARK: - Public properties
    
    let state: State
    var password = ""
    var screenMessage: String {
        state == .protectionInstalled
            ? "Enter your password".localized()
            : "Set a four-digit password to protect the enter to app".localized()
    }
    var attemptCount = 0
    var passwordErrorMessage: String {
        attemptsRemaining > 0
            ? "Try again. ".localized() + "Attempts remaining: ".localized() + "\(attemptsRemaining)"
            : "You have used up all password attempts. You will be logged out.".localized()
    }
    var needLogOut: Bool {
        attemptsRemaining < 1
    }
    
    // MARK: - Private properties
    
    private let maxAttemptCount = 5
    private var attemptsRemaining: Int {
       maxAttemptCount - attemptCount
    }
    
    // MARK: - Initializers
    
    init(state: State) {
        self.state = state
    }
}
