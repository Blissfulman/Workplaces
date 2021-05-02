//
//  TabBarController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Private properties
    
    private var feedCoordinator: FeedCoordinator?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    // MARK: - Private methods
    
    private func configureTabs() {
        tabBar.backgroundColor = Palette.white
        tabBar.barTintColor = Palette.white
        tabBar.tintColor = Palette.orange
        tabBar.unselectedItemTintColor = Palette.grey
        
        let feedNavController = UINavigationController()
        feedCoordinator = FeedCoordinatorImpl(navigationController: feedNavController, onFinish: {})
        feedNavController.tabBarItem.image = Icons.feed
        feedCoordinator?.start()
        
        let newPostVC = UINavigationController(rootViewController: NewPostViewController())
        newPostVC.tabBarItem.image = Icons.newPost
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem.image = Icons.profile
        
        viewControllers = [feedNavController, newPostVC, profileVC]
    }
}
