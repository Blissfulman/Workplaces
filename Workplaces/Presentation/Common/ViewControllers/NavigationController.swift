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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Palette.white
        appearance.shadowColor = Palette.lightGreyBlue
        appearance.titleTextAttributes = [.font: Fonts.bodyLarge]
        appearance.setBackIndicatorImage(Icons.backSmall, transitionMaskImage: Icons.backSmall)
        
        let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [NavigationController.self])
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = Palette.grey
    }
}
