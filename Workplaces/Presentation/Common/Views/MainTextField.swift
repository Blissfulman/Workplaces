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
        // Эта проверка нужна, чтобы при клике в поле, когда оно в состоянии ошибки, картинка не обновлялась
        // Решение мне не нравится, но пока лучшего не нашёл
        if textColor != Palette.orange {
            background = Images.textFieldBackgroundDefault
        }
        clearButtonMode = .whileEditing
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCustomClearButton()
    }
}

// MARK: - Extensions

fileprivate extension UITextField {
    
    func setCustomClearButton() {
        // Это неправильно, но пока что лучшего решения не нашёл
        subviews.forEach {
            if let clearButton = $0 as? UIButton {
                clearButton.frame.size = CGSize(width: 24, height: 24)
                clearButton.setImage(Icons.crossSmall, for: .normal)
            }
        }
    }
}
