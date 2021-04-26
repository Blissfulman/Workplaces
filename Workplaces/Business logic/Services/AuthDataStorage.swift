//
//  AuthDataStorage.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation
import WorkplacesAPI

// Временный файл с временным сервисом

protocol AuthDataStorage {
    func saveAuthData(_ data: AuthorizationData)
    func getAccessToken() -> String
    func getRefreshToken() -> String
}

final class AuthDataStorageImpl: AuthDataStorage {
    
    private let storage: StringStorage
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    
    init(storage: StringStorage) {
        self.storage = storage
    }
    
    func saveAuthData(_ data: AuthorizationData) {
        storage.save(data.accessToken, forKey: accessTokenKey)
        storage.save(data.refreshToken, forKey: refreshTokenKey)
    }
    
    func getAccessToken() -> String {
        storage.get(forKey: accessTokenKey)
    }
    
    func getRefreshToken() -> String {
        storage.get(forKey: refreshTokenKey)
    }
}

protocol StringStorage: AnyObject {
    func save(_ value: String, forKey defaultName: String)
    func get(forKey defaultName: String) -> String
}

extension UserDefaults: StringStorage {
    
    func save(_ value: String, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }

    func get(forKey defaultName: String) -> String {
        (UserDefaults.standard.object(forKey: defaultName) as? String) ?? ""
    }
}
