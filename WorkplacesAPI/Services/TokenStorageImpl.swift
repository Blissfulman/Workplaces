//
//  TokenStorage.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

// Сервис временно основан на UserDefaults

public final class TokenStorageImpl: TokenStorage {
    
    // MARK: - Public properties
    
    public var accessToken: String? {
        storage.get(forKey: accessTokenKey)
    }
    
    public var refreshToken: String? {
        storage.get(forKey: refreshTokenKey)
    }
    
    // MARK: - Private properties
    
    private let storage: StringStorage
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    
    // MARK: - Initializers
    
    public init(storage: StringStorage) {
        self.storage = storage
    }
    
    // MARK: - Public methods
    
    public func saveAuthData(_ data: AuthorizationData) {
        storage.save(data.accessToken, forKey: accessTokenKey)
        storage.save(data.refreshToken, forKey: refreshTokenKey)
    }
    
    public func deleteAuthData() {
        storage.remove(forKey: accessTokenKey)
        storage.remove(forKey: refreshTokenKey)
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
