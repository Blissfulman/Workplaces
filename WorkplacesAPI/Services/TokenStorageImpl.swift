//
//  TokenStorage.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

public final class TokenStorageImpl: TokenStorage {
    
    // MARK: - Public properties
    
    public var isEnteredPinCode = false
    public var temporaryRefreshToken: String?
    public var accessToken: String?
    public var refreshToken: String? {
        get {
            storage.get(forKey: refreshTokenKey)
        }
        set {
            guard let refreshToken = newValue else {
                storage.remove(forKey: refreshTokenKey)
                return
            }
            storage.save(refreshToken, forKey: refreshTokenKey)
        }
    }
    
    // MARK: - Private properties
    
    private let storage: StringStorage
    private let refreshTokenKey = "RefreshToken"
    
    // MARK: - Initializers
    
    public init(storage: StringStorage) {
        self.storage = storage
    }
}

// MARK: - StringStorage

public protocol StringStorage: AnyObject {
    func save(_ value: String, forKey defaultName: String)
    func get(forKey defaultName: String) -> String?
    func remove(forKey defaultName: String)
}

extension UserDefaults: StringStorage {
    
    public func save(_ value: String, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }

    public func get(forKey defaultName: String) -> String? {
        (UserDefaults.standard.object(forKey: defaultName) as? String)
    }
    
    public func remove(forKey defaultName: String) {
        UserDefaults.standard.removeObject(forKey: defaultName)
    }
}
