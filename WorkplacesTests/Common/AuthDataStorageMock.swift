//
//  AuthDataStorageMock.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

import WorkplacesAPI

final class AuthDataStorageMock: AuthDataStorage {
    
    // MARK: - Public properties
    
    public var accessToken: String? {
        storage.get(forKey: accessTokenKey)
    }
    
    public var refreshToken: String? {
        storage.get(forKey: refreshTokenKey)
    }
    
    // MARK: - Private properties
    
    private let storage: StringStorage
    private let accessTokenKey = "AccessTokenTest"
    private let refreshTokenKey = "RefreshTokenTest"
    
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
