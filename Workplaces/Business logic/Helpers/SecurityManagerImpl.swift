//
//  SecurityManagerImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

import Foundation

final class SecurityManagerImpl: SecurityManager {
    
    // MARK: - Public properties
    
    lazy var protectionState = ProtectionState.getState(fromValue: storedState) {
        didSet {
            storedState = protectionState.rawValue
        }
    }
    
    var isAuthorized = false
    var temporaryRefreshToken: String?
    //    var refreshToken: String? // TEMP
    var accessToken: String?
    var stringStorage: StringStorage
    
    // MARK: - Private properties
    
    private var storedState: String {
        get {
            stringStorage.get(forKey: "storedState") ?? ""
        }
        set {
            stringStorage.save(newValue, forKey: "storedState")
        }
    }
    private let keychainManager: KeychainManager
    
    // MARK: - Initializers
    
    init(
        keychainManager: KeychainManager = KeychainManagerImpl(),
        stringStorage: StringStorage = UserDefaults.standard
    ) {
        self.keychainManager = keychainManager
        self.stringStorage = stringStorage
    }
    
    // MARK: - Public methods
    
    func saveRefreshTokenWithPassword(token: String, password: String) -> Bool {
        keychainManager.saveTokenWithPassword(token: token, password: password)
    }
    
    func getRefreshTokenWithPassword(_ password: String) -> String? {
        keychainManager.getTokenWithPassword(password)
    }
    
    func saveRefreshTokenWithBiometry(token: String) -> Bool {
        keychainManager.saveTokenWithBiometry(token: token)
    }
    
    func getRefreshTokenWithBiometry(completion: @escaping (String?) -> Void) {
        keychainManager.getTokenWithBiometry(completion: completion)
    }
    
    func removeRefreshToken() {
        keychainManager.removeToken()
    }
}
