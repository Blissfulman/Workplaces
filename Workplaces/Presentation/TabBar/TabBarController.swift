//
//  TabBarController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    private func configureTabs() {
        tabBar.barTintColor = Palette.white
        tabBar.tintColor = Palette.orange
        
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        feedVC.tabBarItem.image = Icons.feed
        feedVC.title = "Популярное"
        
        let newPostVC = UINavigationController(rootViewController: NewPostViewController())
        newPostVC.tabBarItem.image = Icons.newPost
        newPostVC.title = "Новый пост"
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem.image = Icons.profile
        profileVC.title = "Профиль"
        
        viewControllers = [feedVC, newPostVC, profileVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("Selected \(item) item")
    }
}
