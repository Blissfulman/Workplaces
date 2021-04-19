//
//  SceneDelegate.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AuthorizationCoordinatorProtocol!
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        coordinator = AuthorizationCoordinator(navigationController: navigationController)
        coordinator.start()
        window?.makeKeyAndVisible()
    }
}
