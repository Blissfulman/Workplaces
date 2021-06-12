//
//  SecurityManagerImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

import KeychainAccess

final class SecurityManagerImpl: SecurityManager {
    
    // MARK: - Public properties
    
    var isSavedRefreshToken: Bool {
        keychainStorage.isSavedRefreshToken
    }
    var isSavedPassword: Bool {
        keychainStorage.isSavedPassword
    }
    var isAuthorized = false {
        didSet {
            if isAuthorized { remainingEntryAttemptsCount = Constants.maxEntryAttemptsCount }
        }
    }
    var refreshToken: String?
    var accessToken: String?
    var password = ""
    var remainingEntryAttemptsCount: Int {
        get {
            guard let stringValue = try? keychain.get("RemainingEntryAttemptsCount"),
                  let value = Int(stringValue) else { return 0 }
            return value
        }
        set {
            try? keychain.set("\(newValue)", key: "RemainingEntryAttemptsCount")
        }
    }
    
    // MARK: - Private properties
    
    private let keychainStorage: KeychainStorage
    private let keychain = Keychain()
    
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
        password = ""
    }
}
