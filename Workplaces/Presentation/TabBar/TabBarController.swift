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
    private var profileCoordinator: ProfileCoordinator?
    
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
        
        let feedNavigationController = UINavigationController()
        feedCoordinator = FeedCoordinatorImpl(navigationController: feedNavigationController, onFinish: {})
        feedNavigationController.tabBarItem.image = Icons.feed
        feedCoordinator?.start()
        
        let newPostVC = UINavigationController(rootViewController: NewPostViewController())
        newPostVC.tabBarItem.image = Icons.newPost
        
        let profileNavigationController = UINavigationController()
        profileCoordinator = ProfileCoordinatorImpl(navigationController: profileNavigationController) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                print("Window access error")
                return
            }
            sceneDelegate.applicationCoordinator.start()
        }
        profileNavigationController.tabBarItem.image = Icons.profile
        profileCoordinator?.start()
        
        viewControllers = [feedNavigationController, newPostVC, profileNavigationController]
    }
}
