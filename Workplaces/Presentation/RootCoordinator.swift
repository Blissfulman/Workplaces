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
        switch securityManager.protectionState {
        case .none:
            securityManager.isAuthorized ? startPinCodeCoordinatingController() : startAuthorizationCoordinator()
        case .passwordProtected, .biometryProtected:
            securityManager.isAuthorized ? startTabBarCoordinatingController() : startPinCodeCoordinatingController()
            
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
    
    private func startPinCodeCoordinatingController() {
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
