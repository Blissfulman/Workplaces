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
        navigationBar.tintColor = Palette.orange
        navigationBar.titleTextAttributes = [.font: Fonts.bodyLarge]
    }
}
