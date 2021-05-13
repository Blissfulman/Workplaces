//
//  SceneDelegate.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.04.2021.
//

import UIKit

enum GlobalFlags {
    static var isTesting: Bool {
        UserDefaults.standard.bool(forKey: "isTesting")
    }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public properties
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator!
    
    // MARK: - UIWindowSceneDelegate
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard !GlobalFlags.isTesting else { return }
        
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
