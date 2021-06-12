//
//  SecurityManagerImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

final class SecurityManagerImpl: SecurityManager {
    
    // MARK: - Public properties
    
    var isSavedRefreshToken: Bool {
        keychainStorage.isSavedRefreshToken
    }
    var isSavedPassword: Bool {
        keychainStorage.isSavedPassword
    }
    var isAuthorized = false
    var refreshToken: String?
    var accessToken: String?
    var password = ""
    
    // MARK: - Private properties
    
    private let keychainStorage: KeychainStorage
    
    // MARK: - Initializers
    
    init(keychainStorage: KeychainStorage = ServiceLayer.shared.keychainStorage) {
        self.keychainStorage = keychainStorage
    }
    
    // MARK: - Public methods
    
    func saveRefreshTokenWithPassword(token: String, password: String) -> Bool {
        self.password = password
        return keychainStorage.saveTokenWithPassword(token: token, password: password)
    }
    
    func getRefreshTokenWithPassword(_ password: String) -> String? {
        self.password = password
        return keychainStorage.getTokenWithPassword(password)
    }
    
    func savePasswordWithBiometry(password: String) -> Bool {
        keychainStorage.savePasswordWithBiometry(password: password)
    }
    
    func getPasswordWithBiometry(completion: @escaping (String?) -> Void) {
        keychainStorage.getPasswordWithBiometry(completion: completion)
    }
    
    func logoutReset() {
        isAuthorized = false
        keychainStorage.removeToken()
        accessToken = nil
        refreshToken = nil
    }
}
