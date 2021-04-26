//
//  SettingsStorage.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import Foundation

// Временный файл с временными сервисами

protocol SettingsStorage {
    func saveAuthState(to state: Bool)
    func getAuthState() -> Bool
}

final class SettingsStorageImpl: SettingsStorage {
    
    private let storage: BoolStorage
    private let authStateKey = "AuthState"
    
    init(storage: BoolStorage) {
        self.storage = storage
    }
    
    func saveAuthState(to state: Bool) {
        storage.set(state, forKey: authStateKey)
    }
    
    func getAuthState() -> Bool {
        storage.bool(forKey: authStateKey)
    }
}

protocol BoolStorage: AnyObject {
    func set(_ value: Bool, forKey defaultName: String)
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: BoolStorage {}
