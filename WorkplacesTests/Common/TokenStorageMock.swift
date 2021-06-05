//
//  TokenStorageMock.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

import WorkplacesAPI

final class TokenStorageMock: TokenStorage {
    
    // MARK: - Public properties
    
    var isEnteredPinCode = false
    var temporaryRefreshToken: String?
    var accessToken: String?
    var refreshToken: String? {
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
    private let refreshTokenKey = "RefreshTokenTest"
    
    // MARK: - Initializers
    
    public init(storage: StringStorage) {
        self.storage = storage
    }
}
