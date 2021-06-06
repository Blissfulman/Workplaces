//
//  MainFilledButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit.UIButton

final class MainFilledButton: UIButton {
    
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
        backgroundColor = isEnabled ? Palette.orange : Palette.lightGreyBlue
        titleLabel?.textColor = isEnabled ? Palette.white : Palette.middleGrey
    }
    
    // MARK: - UIButton
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            isHighlighted ? downscaleAnimation(duration: 0.08, scale: 0.98) : resetScaleAnimation(duration: 0.08)
        }
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        backgroundColor = .clear
        isExclusiveTouch = true
        setCornerRadius(UIConstants.buttonCornerRadius)
    }
}
