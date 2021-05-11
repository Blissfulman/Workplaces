//
//  TabBarController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class TabBarController: UITabBarController, Coordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
        
    // MARK: - Private properties
    
    private var feedCoordinator: FeedCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    
    private var feedTab: UIViewController {
        let navigationController = UINavigationController()
        feedCoordinator = FeedCoordinatorImpl(navigationController: navigationController, onFinish: onFinish)
        navigationController.tabBarItem.image = Icons.feed
        feedCoordinator?.start()
        return navigationController
    }
    
    private var newPostTab: UIViewController {
        let newPostVC = NewPostViewController()
        newPostVC.tabBarItem.image = Icons.newPost
        return newPostVC
    }
    
    private var profileTab: UIViewController {
        let navigationController = UINavigationController()
        profileCoordinator = ProfileCoordinatorImpl(
            navigationController: navigationController,
            onFinish: onFinish,
            delegate: self
        )
        navigationController.tabBarItem.image = Icons.profile
        profileCoordinator?.start()
        return navigationController
    }
    
    // MARK: - Initializers
    
    init(onFinish: @escaping VoidBlock) {
        self.onFinish = onFinish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func start() {
        viewControllers = [feedTab, newPostTab, profileTab]
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBar.backgroundColor = Palette.white
        tabBar.barTintColor = Palette.white
        tabBar.tintColor = Palette.orange
        tabBar.unselectedItemTintColor = Palette.grey
    }
}

// MARK: - ProfileCoordinatorDelegate

extension TabBarController: ProfileCoordinatorDelegate {
    
    func goToFeed() {
        selectedIndex = 0
    }
    
    func goToNewPost() {
        selectedIndex = 1
    }
    
    func goToSearchFriends() {
        selectedIndex = 0
        // Так вообще можно?
        feedCoordinator?.showSearchFriendsScreen()
    }
}
