//
//  ProfileCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileCoordinator: Coordinator {}

protocol ProfileCoordinatorDelegate: AnyObject {
    func goToFeed()
    func goToNewPost()
}

final class ProfileCoordinatorImpl: ProfileCoordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    weak var delegate: ProfileCoordinatorDelegate?
    
    // MARK: - Private properties
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController,
        onFinish: @escaping VoidBlock,
        delegate: ProfileCoordinatorDelegate
    ) {
        self.navigationController = navigationController
        self.onFinish = onFinish
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func start() {
        showProfileScreen()
    }
    
    // MARK: - Private methods
    
    private func showProfileScreen() {
        let profileContainerVC = ProfileContainerViewController()
        profileContainerVC.delegate = self
        navigationController?.pushViewController(profileContainerVC, animated: false)
    }
    
    private func showEditProfileScreen(profile: User) {
        let editProfileContainerVC = EditProfileContainerViewController(profile: profile)
        editProfileContainerVC.delegate = self
        navigationController?.pushViewController(editProfileContainerVC, animated: true)
    }
    
    private func showSearchFriendsScreen() {
        let searchFriendsVC = SearchFriendsViewController()
        navigationController?.pushViewController(searchFriendsVC, animated: true)
    }
}

// MARK: - ProfileContainerViewControllerDelegate

extension ProfileCoordinatorImpl: ProfileContainerViewControllerDelegate {
    
    func goToEditProfile(profile: User) {
        showEditProfileScreen(profile: profile)
    }
    
    func goToNewPost() {
        delegate?.goToNewPost()
    }
    
    func goToFeed() {
        delegate?.goToFeed()
    }
    
    func goToSearchFriends() {
        showSearchFriendsScreen()
    }
    
    func signOut() {
        onFinish()
    }
}

// MARK: - EditProfileContainerViewControllerDelegate

extension ProfileCoordinatorImpl: EditProfileContainerViewControllerDelegate {
    
    func profileDidSave() {
        navigationController?.popViewController(animated: true)
    }
}
