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
    
    private var feedTab: UIViewController {
        let feedNavigationController = UINavigationController()
        
        feedCoordinator = FeedCoordinatorImpl(navigationController: feedNavigationController, onFinish: {})
        feedNavigationController.tabBarItem.image = Icons.feed
        feedCoordinator?.start()
        
        return feedNavigationController
    }
    
    private var newPostTab: UIViewController {
        let newPostVC = UINavigationController(rootViewController: NewPostViewController())
        newPostVC.tabBarItem.image = Icons.newPost
        return newPostVC
    }
    
    private var profileTab: UIViewController {
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
        
        return profileNavigationController
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTabs()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBar.backgroundColor = Palette.white
        tabBar.barTintColor = Palette.white
        tabBar.tintColor = Palette.orange
        tabBar.unselectedItemTintColor = Palette.grey
    }
    
    private func configureTabs() {
        viewControllers = [feedTab, newPostTab, profileTab]
    }
}
