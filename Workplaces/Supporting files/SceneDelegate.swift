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
    var rootCoordinator: RootCoordinator!
    
    // MARK: - UIWindowSceneDelegate
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard !GlobalFlags.isTesting else { return }
        
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        rootCoordinator = RootCoordinator(window: window)
        rootCoordinator.start()
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        BlurView.show()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        BlurView.hide()
    }
}
