//
//  FeedCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedCoordinator: Coordinator {}

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
    
    private func showSearchFriendsScreen() {
        let searchFriendsContainerVC = SearchFriendsContainerViewController()
        navigationController?.show(searchFriendsContainerVC, sender: nil)
    }
    
    // MARK: - Private methods
    
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
