//
//  ProfileCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileCoordinator: Coordinator {
    func showNewPostScreen()
}

protocol ProfileCoordinatorDelegate: AnyObject {
    func goToFeed()
}

final class ProfileCoordinatorImpl: ProfileCoordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    weak var delegate: ProfileCoordinatorDelegate?
    
    // MARK: - Private properties
    
    private weak var navigationController: NavigationController?
    
    // MARK: - Initializers
    
    init(
        navigationController: NavigationController,
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
    
    func showNewPostScreen() {
        let newPostContainerVC = NewPostContainerViewController(delegate: self)
        navigationController?.show(newPostContainerVC, sender: nil)
    }
    
    // MARK: - Private methods
    
    private func showProfileScreen() {
        let profileContainerVC = ProfileContainerViewController()
        profileContainerVC.delegate = self
        navigationController?.show(profileContainerVC, sender: nil)
    }
    
    private func showEditProfileScreen(profile: User) {
        let editProfileContainerVC = EditProfileContainerViewController(profile: profile)
        editProfileContainerVC.delegate = self
        navigationController?.show(editProfileContainerVC, sender: nil)
    }
    
    private func showSearchFriendsScreen() {
        let searchFriendsContainerVC = SearchFriendsContainerViewController()
        navigationController?.show(searchFriendsContainerVC, sender: nil)
    }
}

// MARK: - ProfileContainerViewControllerDelegate

extension ProfileCoordinatorImpl: ProfileContainerViewControllerDelegate {
    
    func goToEditProfile(profile: User) {
        showEditProfileScreen(profile: profile)
    }
    
    func goToNewPost() {
        showNewPostScreen()
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

// MARK: - NewPostContainerViewControllerDelegate

extension ProfileCoordinatorImpl: NewPostContainerViewControllerDelegate {
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
