//
//  LocalAuthenticationManager.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.06.2021.
//

import LocalAuthentication

// Пока не используется
final class LocalAuthenticationManager {
    
    // MARK: - Public methods
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        guard #available(iOS 8.0, *, *) else {
            print("Версия iOS не поддерживает TouchID")
            completion(false)
            return
        }
        
        let context = LAContext()
        setupAuthenticationContext(context: context)
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            completion(false)
            return
        }
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Fast and safe authentication in your app"
        ) { success, evaluationError in
            
            guard success else {
                print(evaluationError?.localizedDescription ?? "No error")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    // MARK: - Private methods
    
    private func setupAuthenticationContext(context: LAContext) {
        context.localizedReason = "Use for fast and safe authentication in your app"
        context.localizedCancelTitle = "Cancel"
        context.localizedFallbackTitle = "Enter password"
        
        context.touchIDAuthenticationAllowableReuseDuration = 600
    }
}
