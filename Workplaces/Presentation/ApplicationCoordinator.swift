//
//  ApplicationCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 25.04.2021.
//

import UIKit

final class ApplicationCoordinator {
    
    // MARK: - Private properties
    
    private weak var window: UIWindow?
    private let authDataStorage: AuthDataStorage
    private var authorizationCoordinator: AuthorizationCoordinator?
    
    // MARK: - Initializers
    
    init(window: UIWindow?, authDataStorage: AuthDataStorage) {
        self.window = window
        self.authDataStorage = authDataStorage
    }
    
    // MARK: - Public methods
    
    func start() {
        if !authDataStorage.getAccessToken().isEmpty {
            window?.rootViewController = TabBarController()
        } else {
            let navigationController = UINavigationController()
            window?.rootViewController = navigationController
            authorizationCoordinator = AuthorizationCoordinatorImpl(
                navigationController: navigationController
            ) { [weak self] in
                self?.window?.rootViewController = TabBarController()
            }
            authorizationCoordinator?.start()
        }
    }
}
