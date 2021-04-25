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
    
    init(storage: BoolStorage) {
        self.storage = storage
    }
    
    func saveAuthState(to state: Bool) {
        storage.set(state, forKey: "AuthState")
    }
    
    func getAuthState() -> Bool {
        storage.bool(forKey: "AuthState")
    }
}

protocol BoolStorage: AnyObject {
    func set(_ value: Bool, forKey dafaultName: String)
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: BoolStorage {}
