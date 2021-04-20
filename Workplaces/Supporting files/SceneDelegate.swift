//
//  SceneDelegate.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.04.2021.
//

import Firebase
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var coordinator: AuthorizationCoordinatorProtocol!
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        checkAuthorization()
        window?.makeKeyAndVisible()
    }
    
    private func checkAuthorization() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if user == nil {
                let navigationController = UINavigationController()
                self.window?.rootViewController = navigationController
                self.coordinator = AuthorizationCoordinator(navigationController: navigationController)
                self.coordinator.start()
            } else {
                print("User already exists")
                let tabBarController = TabBarController()
                self.window?.rootViewController = tabBarController
            }
        }
    }
}
