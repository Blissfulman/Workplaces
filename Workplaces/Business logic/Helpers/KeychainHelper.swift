//
//  KeychainHelper.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

import LocalAuthentication

final class KeychainHelper {
    
    // MARK: - Public methods
    
    static func getPasswordSecAccessControl() -> SecAccessControl {
        var access: SecAccessControl?
        var error: Unmanaged<CFError>?
        
        access = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            .applicationPassword,
            &error
        )
        precondition(access != nil, "SecAccessControlCreateWithFlags failed")
        return access!
    }
    
    static func getBioSecAccessControl() -> SecAccessControl {
        var access: SecAccessControl?
        var error: Unmanaged<CFError>?
        
        if #available(iOS 11.3, *) {
            access = SecAccessControlCreateWithFlags(
                kCFAllocatorDefault,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                .biometryCurrentSet,
                &error
            )
        } else {
            access = SecAccessControlCreateWithFlags(
                kCFAllocatorDefault,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                .touchIDCurrentSet,
                &error
            )
        }
        precondition(access != nil, "SecAccessControlCreateWithFlags failed")
        return access!
    }
    
    static func createPasswordProtectedEntry(key: String, data: Data, password: String) -> OSStatus {
        remove(key: key)
        
        let context = LAContext()
        context.setCredential(password.data(using: .utf8), type: .applicationPassword)
        
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecAttrAccessControl as String: getPasswordSecAccessControl(),
            kSecValueData as String: data as NSData,
            kSecUseAuthenticationContext: context
        ] as CFDictionary
        
        return SecItemAdd(query, nil)
    }
    
    static func createBioProtectedEntry(key: String, data: Data) -> OSStatus {
        remove(key: key)
        
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecAttrAccessControl as String: getBioSecAccessControl(),
            kSecValueData as String: data
        ] as CFDictionary
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    static func remove(key: String) {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    // swiftlint:disable force_cast
    
    static func loadPasswordProtected(key: String, context: LAContext? = nil) -> Data? {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecAttrAccessControl as String: getPasswordSecAccessControl(),
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        if let context = context {
            query[kSecUseAuthenticationContext as String] = context
            query[kSecUseAuthenticationUI as String] = kSecUseAuthenticationUIFail
        }
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return (dataTypeRef! as! Data)
        } else {
            return nil
        }
    }
    
    static func loadBioProtected(
        key: String,
        context: LAContext? = nil,
        prompt: String? = nil
    ) -> Data? {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecAttrAccessControl as String: getBioSecAccessControl(),
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        if let context = context {
            query[kSecUseAuthenticationContext as String] = context
            query[kSecUseAuthenticationUI as String] = kSecUseAuthenticationUISkip
        }
        
        if let prompt = prompt {
            query[kSecUseOperationPrompt as String] = prompt
        }
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return (dataTypeRef! as! Data)
        } else {
            return nil
        }
    }
    
    static func available(key: String) -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecUseAuthenticationUI as String: kSecUseAuthenticationUIFail
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        // errSecInteractionNotAllowed - for a protected item
        // errSecAuthFailed - when TouchID is locked
        return status == noErr || status == errSecInteractionNotAllowed || status == errSecAuthFailed
    }
}
