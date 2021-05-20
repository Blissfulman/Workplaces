//
//  MainUnfilledButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.05.2021.
//

import UIKit

final class MainUnfilledButton: UIButton {
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        titleLabel?.textColor = isEnabled ? Palette.orange : Palette.middleGrey
    }
}
