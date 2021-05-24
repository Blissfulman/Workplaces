//
//  RoundedTabBarController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.05.2021.
//

import UIKit

class RoundedTabBarController: UITabBarController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UIDevice.isSquareScreen() {
            setupRoundedTabBar()
        }
        tabBar.tintColor = Palette.orange
        tabBar.unselectedItemTintColor = Palette.grey
    }
    
    // MARK: - Private methods
    
    private func setupRoundedTabBar() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(
            roundedRect: CGRect(x: tabBar.center.x - 88, y: 0, width: 176, height: 60),
            cornerRadius: 30
        ).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.1
        layer.fillColor = Palette.white.cgColor
        tabBar.layer.insertSublayer(layer, at: 0)
        
        tabBar.itemWidth = 24.0
        tabBar.itemPositioning = .centered
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
}
