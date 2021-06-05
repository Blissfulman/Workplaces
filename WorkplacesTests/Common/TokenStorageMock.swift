//
//  TokenStorageMock.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

import WorkplacesAPI

final class TokenStorageMock: TokenStorage {
    
    // MARK: - Public properties
    
    public var accessToken: String? {
        get {
            storage.get(forKey: accessTokenKey)
        }
        set {
            guard let accessToken = newValue else {
                storage.remove(forKey: accessTokenKey)
                return
            }
            storage.save(accessToken, forKey: accessTokenKey)
        }
    }
    
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
    private let accessTokenKey = "AccessTokenTest"
    private let refreshTokenKey = "RefreshTokenTest"
    
    // MARK: - Initializers
    
    public init(storage: StringStorage) {
        self.storage = storage
    }
}
