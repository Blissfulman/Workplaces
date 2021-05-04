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
    
    // MARK: - Private methods
    
    private func showFeedScreen() {
        let feedVC = FeedViewController()
        
        feedVC.didTapFindFriendButton = { [weak self] in
            self?.showFindFriendsScreen()
        }
        
        navigationController?.pushViewController(feedVC, animated: false)
    }
    
    private func showFindFriendsScreen() {
        let searchFriendsVC = SearchFriendsViewController()
        navigationController?.pushViewController(searchFriendsVC, animated: true)
    }
}
