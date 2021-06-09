//
//  KeychainStorageImpl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.06.2021.
//

import KeychainAccess
import LocalAuthentication

final class KeychainStorageImpl: KeychainStorage {
    
    var protectionState: String? {
        get {
            try? keychain.get(protectionStateKey)
        }
        set {
            try? keychain.set(newValue ?? "", key: protectionStateKey)
        }
    }
    
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
    
    private let keychain = Keychain()
    private let tokenKey = "Token"
    private let protectionStateKey = "ProtectionState"
    
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
    
    func saveTokenWithPassword(token: String, password: String) -> Bool {
        let result = KeychainHelper.createPasswordProtectedEntry(
            key: tokenKey,
            data: Data(token.utf8),
            password: password
        )
        if result == noErr {
            print("Token successfully saved!") // TEMP
            return true
        } else {
            print("Token saving failed, osstatus=\(result)") // TEMP
            return false
        }
    }
    
    func getTokenWithPassword(_ password: String) -> String? {
        let context = LAContext()
        let password = password
        context.setCredential(Data(password.utf8), type: .applicationPassword)
        let data = KeychainHelper.loadPasswordProtected(key: tokenKey, context: context)
        return getTokenFromData(data)
    }
    
    func saveTokenWithBiometry(token: String) -> Bool {
        let result = KeychainHelper.createBioProtectedEntry(key: tokenKey, data: Data(token.utf8))
        if result == noErr {
            print("Token successfully saved") // TEMP
            return true
        } else {
            print("Token saving failed, osstatus=\(result)") // TEMP
            return false
        }
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
        print("Token was removed") // TEMP
    }
    
    // TEMP?
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
