//
//  UITextField+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

extension UITextField {
    
    func setCustomClearButton() {
        let button = UIButton(type: .custom)
        button.setImage(Icons.crossSmall, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.contentMode = .scaleToFill
        rightView = button
        rightViewMode = .whileEditing
        button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }
    
    @objc private func clearText() {
        self.text = ""
    }
}
