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
        securityManager.isSavedRefreshToken && securityManager.isAuthorized
            ? startTabBarCoordinatingController()
            : startAuthorizationCoordinator()
    }
    
    func forcedLogOutIfAuthorized() {
        if securityManager.isAuthorized {
            securityManager.logoutReset()
            start()
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
    
    private func startTabBarCoordinatingController() {
        let tabBarCoordinatingController = TabBarCoordinatingController { [weak self] in
            self?.start()
        }
        tabBarCoordinatingController.start()
        window?.rootViewController = tabBarCoordinatingController
    }
}
