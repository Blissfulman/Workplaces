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
            let tabBarController = TabBarController { [weak self] in
                self?.start()
            }
            tabBarController.start()
            window?.rootViewController = tabBarController
        } else {
            let navigationController = UINavigationController()
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
