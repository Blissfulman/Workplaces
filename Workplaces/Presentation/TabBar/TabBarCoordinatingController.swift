//
//  TabBarCoordinatingController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class TabBarCoordinatingController: RoundedTabBarController, Coordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private var feedCoordinator: FeedCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    
    private lazy var feedTab: UIViewController = {
        let navigationController = NavigationController()
        feedCoordinator = FeedCoordinatorImpl(navigationController: navigationController, onFinish: onFinish)
        navigationController.tabBarItem.image = Icons.feed
        feedCoordinator?.start()
        return navigationController
    }()
    
    private lazy var newPostTab: UIViewController = {
        let newPostContainerVC = NewPostContainerViewController(delegate: nil)
        newPostContainerVC.tabBarItem.image = Icons.newPost
        return newPostContainerVC
    }()
    
    private lazy var profileTab: UIViewController = {
        let navigationController = NavigationController()
        profileCoordinator = ProfileCoordinatorImpl(
            navigationController: navigationController,
            onFinish: onFinish,
            delegate: self
        )
        navigationController.tabBarItem.image = Icons.profile
        profileCoordinator?.start()
        return navigationController
    }()
    
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
        delegate = self
        viewControllers = [feedTab, newPostTab, profileTab]
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        if !UIDevice.isSquareScreen() {
            tabBar.items?.forEach { $0.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -22, right: 0) }
        } else {
            tabBar.backgroundColor = Palette.white
            tabBar.barTintColor = Palette.white
        }
    }
}

// MARK: - Tab bar controller delegate

extension TabBarCoordinatingController: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        guard viewController is NewPostContainerViewController else { return true }
        
        if selectedIndex == 0 {
            feedCoordinator?.showNewPostScreen()
        }
        if selectedIndex == 2 {
            profileCoordinator?.showNewPostScreen()
        }
        return false
    }
}

// MARK: - ProfileCoordinatorDelegate

extension TabBarCoordinatingController: ProfileCoordinatorDelegate {
    
    func goToFeed() {
        selectedIndex = 0
    }
    
    func goToNewPost() {
        selectedIndex = 1
    }
}
