//
//  SecurityManagerFake.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

@testable import Workplaces

final class SecurityManagerFake: SecurityManager {
    
    // MARK: - Public properties
    
    var isSavedRefreshToken = false
    var isSavedPassword = false
    var isAuthorized = false
    var refreshToken: String?
    var accessToken: String?
    var password = ""
    var remainingEntryAttemptsCount = 5
    
    // MARK: - Public methods
    
    func saveRefreshTokenWithPassword(token: String, password: String) -> Bool { true }
    
    func getRefreshTokenWithPassword(_ password: String) -> String? { "" }
    
    func savePasswordWithBiometry(password: String) -> Bool { true }
    
    func getPasswordWithBiometry(completion: @escaping (String?) -> Void) {}
    
    func logoutReset() {
        isAuthorized = false
        refreshToken = nil
        accessToken = nil
        password = ""
    }
}
