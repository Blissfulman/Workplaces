//
//  NavigationController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class NavigationController: UINavigationController {
    
    // MARK: - Static methods
    
    static func setupAppearance() {
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = Palette.white
        apperance.shadowColor = Palette.lightGreyBlue
        apperance.titleTextAttributes = [.font: Fonts.bodyLarge]
        apperance.setBackIndicatorImage(Icons.backSmall, transitionMaskImage: Icons.backSmall)
        
        let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [NavigationController.self])
        navigationBar.standardAppearance = apperance
        navigationBar.compactAppearance = apperance
        navigationBar.tintColor = Palette.grey
    }
}
