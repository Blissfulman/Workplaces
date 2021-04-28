//
//  AuthDataStorage.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import WorkplacesAPI

// Временный файл с временным сервисом

protocol AuthDataStorage {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    func saveAuthData(_ data: AuthorizationData)
    func deleteAuthData()
}

final class AuthDataStorageImpl: AuthDataStorage {
    
    // MARK: - Public properties
    
    var accessToken: String? {
        storage.get(forKey: accessTokenKey)
    }
    
    var refreshToken: String? {
        storage.get(forKey: refreshTokenKey)
    }
    
    // MARK: - Private properties
    
    private let storage: StringStorage
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    
    // MARK: - Initializers
    
    init(storage: StringStorage) {
        self.storage = storage
    }
    
    // MARK: - Public methods
    
    func saveAuthData(_ data: AuthorizationData) {
        storage.save(data.accessToken, forKey: accessTokenKey)
        storage.save(data.refreshToken, forKey: refreshTokenKey)
    }
    
    func deleteAuthData() {
        storage.remove(forKey: accessTokenKey)
        storage.remove(forKey: refreshTokenKey)
    }
}

// MARK: - StringStorage

protocol StringStorage: AnyObject {
    func save(_ value: String, forKey defaultName: String)
    func get(forKey defaultName: String) -> String?
    func remove(forKey defaultName: String)
}

extension UserDefaults: StringStorage {
    
    func save(_ value: String, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }

    func get(forKey defaultName: String) -> String? {
        (UserDefaults.standard.object(forKey: defaultName) as? String)
    }
    
    func remove(forKey defaultName: String) {
        UserDefaults.standard.removeObject(forKey: defaultName)
    }
}
