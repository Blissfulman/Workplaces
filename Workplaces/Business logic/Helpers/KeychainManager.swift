//
//  KeychainManager.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.06.2021.
//

import LocalAuthentication

// MARK: - Protocols

protocol KeychainManager {
    
    /// Сохранение токена с защитой паролем.
    /// - Parameters:
    ///   - token: Токен.
    ///   - password: Пароль.
    func saveTokenWithPassword(token: String, password: String)
    
    /// Получение защищённого паролем токена. В случае успешного получения возвращается токен, в противном случае - `nil`.
    /// - Parameter password: Пароль.
    func getTokenWithPassword(_ password: String) -> String?
    
    /// Сохранение токена с защитой биометрией.
    /// - Parameter token: Токен.
    func saveTokenWithBiometry(token: String)
    
    /// Получение защищённого биометрией токена.
    /// - Parameter completion: Обработчик завершения, в который в случае успешного получения возвращается токен, в противном случае - `nil`.
    func getTokenWithBiometry(completion: @escaping (String?) -> Void)
    
    /// Удаление сохранённого токена.
    func removeToken()
}

final class KeychainManagerImpl: KeychainManager {
    
    // MARK: - Nested types
    
    private enum BiometryState: CustomStringConvertible {
        case available, locked, notAvailable
        
        var description: String {
            switch self {
            case .available:
                return "available"
            case .locked:
                return "locked (temporarily)"
            case .notAvailable:
                return "notAvailable (turned off/not enrolled)"
            }
        }
    }
    
    // MARK: - Private properties
    
    private let tokenKey = "TokenKey"
    
    private var biometryState: BiometryState {
        let authContext = LAContext()
        var error: NSError?
        
        let biometryAvailable = authContext.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error
        )
        if let laError = error as? LAError, laError.code == LAError.Code.biometryLockout {
            return .locked
        }
        return biometryAvailable ? .available : .notAvailable
    }
    
    // MARK: - Public methods
    
    func saveTokenWithPassword(token: String, password: String) {
        let result = KeychainHelper.createPasswordProtectedEntry(
            key: tokenKey,
            data: Data(token.utf8),
            password: password
        )
        if result == noErr {
            print("Token successfully created!")
        } else {
            print("Token saving failed, osstatus=\(result)")
        }
    }
    
    func getTokenWithPassword(_ password: String) -> String? {
        let context = LAContext()
        let password = password
        context.setCredential(Data(password.utf8), type: .applicationPassword)
        let data = KeychainHelper.loadPasswordProtected(key: tokenKey, context: context)
        return getTokenFromData(data)
    }
    
    func saveTokenWithBiometry(token: String) {
        let result = KeychainHelper.createBioProtectedEntry(key: tokenKey, data: Data(token.utf8))
        print(result == noErr ? "Entry created" : "Entry creation failed, osstatus=\(result)")
    }
    
    func getTokenWithBiometry(completion: @escaping (String?) -> Void) {
        checkBiometryState { success in
            guard success else {
                completion(nil)
                return
            }
            if let data = KeychainHelper.loadBioProtected(
                key: self.tokenKey,
                prompt: "Access sample keychain entry"
            ) {
                completion(String(decoding: data, as: UTF8.self))
            } else {
                completion(nil)
            }
        }
    }
    
    func removeToken() {
        KeychainHelper.remove(key: tokenKey)
        print("Token was removed")
    }
    
    func checkBiometry() {
        let entryExists = KeychainHelper.available(key: tokenKey)
        print(entryExists ? "Entry exists" : "Entry doesn't exist")
    }
    
    // MARK: - Private methods
    
    private func getTokenFromData(_ data: Data?) -> String? {
        guard let data = data else { return nil }
        return String(decoding: data, as: UTF8.self)
    }
    
    private func checkBiometryState(_ completion: @escaping (Bool) -> Void) {
        print("Biometry state: " + biometryState.description)
        
        let bioState = biometryState
        guard bioState != .notAvailable else {
            print("Can't read entry, biometry not available")
            completion(false)
            return
        }
        if bioState == .locked {
            // To unlock biometric authentication iOS requires user to enter a valid passcode
            let authContext = LAContext()
            authContext.evaluatePolicy(
                LAPolicy.deviceOwnerAuthentication,
                localizedReason: "Access sample keychain entry"
            ) { success, error in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        print("Can't read entry, error: \(error?.localizedDescription ?? "-")")
                        completion(false)
                    }
                }
            }
        } else {
            completion(true)
        }
    }
}
