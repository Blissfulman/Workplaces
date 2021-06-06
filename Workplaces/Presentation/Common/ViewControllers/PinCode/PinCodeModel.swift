//
//  PinCodeModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

final class PinCodeModel {
    
    // MARK: - Nested types
    
    enum State {
        case protectionInstalled
        case protectionNotInstalled
    }
    
    // MARK: - Public properties
    
    let state: State
    var password = ""
    var message: String {
        state == .protectionInstalled
            ? "Enter your password".localized()
            : "Set a four-digit password to protect the enter to app".localized()
    }
    
    // MARK: - Initializers
    
    init(state: State) {
        self.state = state
    }
}
