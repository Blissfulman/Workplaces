//
//  ProfileCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileCoordinator: Coordinator {}

final class ProfileCoordinatorImpl: ProfileCoordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, onFinish: @escaping VoidBlock) {
        self.navigationController = navigationController
        self.onFinish = onFinish
    }
    
    // MARK: - Public methods
    
    func start() {
        showProfileScreen()
    }
    
    // MARK: - Private methods
    
    private func showProfileScreen() {
        let profileVC = ProfileViewController()
        
        profileVC.didTapEditProfileButton = { [weak self] in
            self?.showEditProfileScreen()
        }
        
        profileVC.didTapLogOutButton = { [weak self] in
            self?.onFinish()
        }
        
        navigationController?.pushViewController(profileVC, animated: false)
    }
    
    private func showEditProfileScreen() {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}
