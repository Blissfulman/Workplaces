//
//  RootCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import UIKit
import WorkplacesAPI

final class RootCoordinator {
    
    // MARK: - Private properties
    
    private weak var window: UIWindow?
    private let securityManager: SecurityManager
    private var authorizationCoordinator: AuthorizationCoordinator?
    
    // MARK: - Initializers
    
    init(window: UIWindow?, securityManager: SecurityManager = ServiceLayer.shared.securityManager) {
        self.window = window
        self.securityManager = securityManager
    }
    
    // MARK: - Public methods
    
    func start() {
        if securityManager.isSavedRefreshToken {
            securityManager.isAuthorized ? startTabBarCoordinatingController() : startProtectionCoordinatingController()
        } else {
            securityManager.isAuthorized ? startProtectionCoordinatingController() : startAuthorizationCoordinator()
        }
    }
    
    // MARK: - Private methods
    
    private func startAuthorizationCoordinator() {
        let navigationController = NavigationController()
        authorizationCoordinator = AuthorizationCoordinatorImpl(
            navigationController: navigationController
        ) { [weak self] in
            self?.start()
        }
        authorizationCoordinator?.start()
        window?.rootViewController = navigationController
    }
    
    private func startProtectionCoordinatingController() {
        let protectionCoordinatingController = ProtectionCoordinatingController { [weak self] in
            self?.start()
        }
        protectionCoordinatingController.start()
        window?.rootViewController = protectionCoordinatingController
    }
    
    private func startTabBarCoordinatingController() {
        let tabBarCoordinatingController = TabBarCoordinatingController { [weak self] in
            self?.start()
        }
        tabBarCoordinatingController.start()
        window?.rootViewController = tabBarCoordinatingController
    }
}
