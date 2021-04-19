//
//  CustomButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class CustomButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 14
        clipsToBounds = true
    }
}
