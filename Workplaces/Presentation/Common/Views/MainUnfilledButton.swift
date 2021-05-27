//
//  MainUnfilledButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.05.2021.
//

import UIKit

final class MainUnfilledButton: UIButton {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.textColor = isEnabled ? Palette.orange : Palette.middleGrey
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        backgroundColor = .clear
        isExclusiveTouch = true
    }
}
