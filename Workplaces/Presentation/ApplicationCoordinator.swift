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
    private let settingsStorage: SettingsStorage
    private var authorizationCoordinator: AuthorizationCoordinator?
    
    // MARK: - Initializers
    
    init(window: UIWindow?, settingsStorage: SettingsStorage) {
        self.window = window
        self.settingsStorage = settingsStorage
    }
    
    // MARK: - Public methods
    
    func start() {
        if settingsStorage.getAuthState() {
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
