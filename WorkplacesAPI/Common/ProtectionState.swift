//
//  ProtectionState.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

public enum ProtectionState: String {
    case none               // Защита входа не устанавливалась
    case passwordProtected  // Пользователь установил защиту входа паролем
    case biometryProtected  // Пользователь установил защиту входа биометрическими данными
    
    // MARK: - Static methods
    
    public static func getState(fromValue value: String?) -> Self {
        guard let value = value,
              let state = Self(rawValue: value) else { return .none }
        return state
    }
}
