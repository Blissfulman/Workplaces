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
    private let tokenStorage: TokenStorage
    private var authorizationCoordinator: AuthorizationCoordinator?
    
    // MARK: - Initializers
    
    init(window: UIWindow?, tokenStorage: TokenStorage = ServiceLayer.shared.tokenStorage) {
        self.window = window
        self.tokenStorage = tokenStorage
    }
    
    // MARK: - Public methods
    
    func start() {
        if (tokenStorage.refreshToken == nil) && (tokenStorage.temporaryRefreshToken == nil) {
            startAuthorizationCoordinator()
        } else {
            tokenStorage.isEnteredPinCode ? startTabBarCoordinatingController() : startPinCodeCoordinatingController()
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
        let pinCodeCoordinatingController = PinCodeCoordinatingController { [weak self] in
            self?.start()
        }
        pinCodeCoordinatingController.start()
        window?.rootViewController = pinCodeCoordinatingController
    }
    
    private func startTabBarCoordinatingController() {
        let tabBarCoordinatingController = TabBarCoordinatingController { [weak self] in
            self?.start()
        }
        tabBarCoordinatingController.start()
        window?.rootViewController = tabBarCoordinatingController
    }
}
