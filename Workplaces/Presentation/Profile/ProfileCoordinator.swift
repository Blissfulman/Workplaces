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
        profileVC.delegate = self
        navigationController?.pushViewController(profileVC, animated: false)
    }
    
    private func showEditProfileScreen(profile: User) {
        let editProfileVC = EditProfileViewController(profile: profile)
        editProfileVC.delegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}

// MARK: - ProfileScreenDelegate

extension ProfileCoordinatorImpl: ProfileScreenDelegate {
    
    func goToEditProfile(profile: User) {
        showEditProfileScreen(profile: profile)
    }
    
    func signOut() {
        onFinish()
    }
}

// MARK: - EditProfileScreenDelegate

extension ProfileCoordinatorImpl: EditProfileScreenDelegate {
    
    func profileDidSave() {
        navigationController?.popViewController(animated: true)
    }
    
}
