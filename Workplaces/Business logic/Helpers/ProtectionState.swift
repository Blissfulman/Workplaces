//
//  ProtectionState.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

enum ProtectionState: String {
    
    case none               // Защита входа не устанавливалась
    case passwordProtected  // Пользователь установил защиту входа паролем
    case biometryProtected  // Пользователь установил защиту входа биометрическими данными
    
    // MARK: - Static methods
    
    static func getState(fromValue value: String?) -> Self? {
        guard let value = value else { return nil }
        return Self(rawValue: value)
    }
}
