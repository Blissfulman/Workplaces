//
//  FeedCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedCoordinator: Coordinator {
    func showSearchFriendsScreen()
}

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
    
    func showSearchFriendsScreen() {
        let searchFriendsVC = SearchFriendsViewController()
        navigationController?.pushViewController(searchFriendsVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func showFeedScreen() {
        let feedVC = FeedViewController()
        feedVC.delegate = self
        navigationController?.pushViewController(feedVC, animated: false)
    }
}

// MARK: - FeedScreenDelegate

extension FeedCoordinatorImpl: FeedScreenDelegate {
    
    func goToSearchFriends() {
        showSearchFriendsScreen()
    }
}
