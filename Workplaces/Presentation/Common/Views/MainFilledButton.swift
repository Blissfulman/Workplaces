//
//  MainFilledButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class MainFilledButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isEnabled ? Palette.orange : Palette.lightGreyBlue
        titleLabel?.textColor = isEnabled ? Palette.white : Palette.middleGrey
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = UIConstants.buttonCornerRadius
        clipsToBounds = true
    }
}
