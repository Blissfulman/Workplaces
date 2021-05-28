//
//  RootCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import UIKit

final class RootCoordinator {
    
    // MARK: - Private properties
    
    private weak var window: UIWindow?
    private let authDataStorage: AuthDataStorage
    private var authorizationCoordinator: AuthorizationCoordinator?
    
    // MARK: - Initializers
    
    init(window: UIWindow?, authDataStorage: AuthDataStorage = ServiceLayer.shared.authDataStorage) {
        self.window = window
        self.authDataStorage = authDataStorage
    }
    
    // MARK: - Public methods
    
    func start() {
        if authDataStorage.accessToken != nil {
            let tabBarCoordinatingController = TabBarCoordinatingController { [weak self] in
                self?.start()
            }
            tabBarCoordinatingController.start()
            window?.rootViewController = tabBarCoordinatingController
        } else {
            let navigationController = NavigationController()
            authorizationCoordinator = AuthorizationCoordinatorImpl(
                navigationController: navigationController
            ) { [weak self] in
                self?.start()
            }
            authorizationCoordinator?.start()
            window?.rootViewController = navigationController
        }
    }
}
