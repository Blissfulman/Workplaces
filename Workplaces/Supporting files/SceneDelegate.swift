//
//  SceneDelegate.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.04.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        applicationCoordinator = ApplicationCoordinator(
            window: window,
            authDataStorage: ServiceLayer.shared.authDataStorage
        )
        applicationCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
