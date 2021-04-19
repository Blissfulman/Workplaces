//
//  UINavigationController+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarApperance = UINavigationBarAppearance()
        navigationBarApperance.backgroundColor = .white
        navigationBarApperance.titleTextAttributes = [.font: Fonts.bodyLarge]
        navigationBar.standardAppearance = navigationBarApperance
        navigationBar.tintColor = Palette.grey
    }
}
