//
//  MainTextField.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.05.2021.
//

import UIKit

final class MainTextField: UITextField {
    
    // MARK: - Private properties
    
    private let textPadding = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 40)
    
    // MARK: - UIView
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if textColor != Palette.orange {
            background = Images.textFieldBackgroundDefault
        }
    }
    
    // MARK: - UITextField
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
