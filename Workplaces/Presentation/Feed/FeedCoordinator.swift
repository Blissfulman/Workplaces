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
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, onFinish: @escaping VoidBlock) {
        self.navigationController = navigationController
        self.onFinish = onFinish
    }
    
    // MARK: - Public methods
    
    func start() {
        showFeedScreen()
    }
    
    private func showSearchFriendsScreen() {
        let searchFriendsVC = SearchFriendsViewController()
        navigationController?.pushViewController(searchFriendsVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func showFeedScreen() {
        let feedContainerVC = FeedContainerViewController()
        feedContainerVC.delegate = self
        navigationController?.pushViewController(feedContainerVC, animated: false)
    }
}

// MARK: - FeedContainerViewControllerDelegate

extension FeedCoordinatorImpl: FeedContainerViewControllerDelegate {
    
    func goToSearchFriends() {
        showSearchFriendsScreen()
    }
}
