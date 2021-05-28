//
//  MainBarButtonItem.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 27.05.2021.
//

import UIKit.UIBarButtonItem

class MainBarButtonItem: UIBarButtonItem {
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        setTitleTextAttributes([.foregroundColor: Palette.black, .font: Fonts.bodyLarge], for: .normal)
        setTitleTextAttributes([.foregroundColor: Palette.middleGrey, .font: Fonts.bodyLarge], for: .highlighted)
    }
}
