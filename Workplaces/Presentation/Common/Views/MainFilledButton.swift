//
//  MainFilledButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class MainFilledButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            isHighlighted ? downscaleAnimation() : resetScaleAnimation()
        }
    }
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isEnabled ? Palette.orange : Palette.lightGreyBlue
        titleLabel?.textColor = isEnabled ? Palette.white : Palette.middleGrey
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setCornerRadius(UIConstants.buttonCornerRadius)
        clipsToBounds = true
    }
}
