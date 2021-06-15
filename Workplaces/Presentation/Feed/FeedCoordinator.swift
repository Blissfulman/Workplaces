//
//  FeedCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedCoordinator: Coordinator {
    func showNewPostScreen()
}

final class FeedCoordinatorImpl: FeedCoordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private weak var navigationController: NavigationController?
    
    // MARK: - Initializers
    
    init(navigationController: NavigationController, onFinish: @escaping VoidBlock) {
        self.navigationController = navigationController
        self.onFinish = onFinish
    }
    
    // MARK: - Public methods
    
    func start() {
        showFeedScreen()
    }
    
    func showNewPostScreen() {
        let newPostContainerVC = NewPostContainerViewController(delegate: self)
        navigationController?.show(newPostContainerVC, sender: nil)
    }
    
    // MARK: - Private methods
    
    private func showSearchFriendsScreen() {
        let searchFriendsContainerVC = SearchFriendsContainerViewController()
        navigationController?.show(searchFriendsContainerVC, sender: nil)
    }
    
    private func showFeedScreen() {
        let feedContainerVC = FeedContainerViewController()
        feedContainerVC.delegate = self
        navigationController?.show(feedContainerVC, sender: nil)
    }
}

// MARK: - FeedContainerViewControllerDelegate

extension FeedCoordinatorImpl: FeedContainerViewControllerDelegate {
    
    func goToSearchFriends() {
        showSearchFriendsScreen()
    }
}

// MARK: - NewPostContainerViewControllerDelegate

extension FeedCoordinatorImpl: NewPostContainerViewControllerDelegate {
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
