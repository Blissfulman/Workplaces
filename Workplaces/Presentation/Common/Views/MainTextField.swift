//
//  MainTextField.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.05.2021.
//

import UIKit.UITextField

final class MainTextField: UITextField {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - UITextField
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIConstants.textFieldPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIConstants.textFieldPadding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Необходимо, чтобы убрать баг с "плывущим" rightView при первом тапе по полю
        let rightViewX = frame.width - (rightView?.frame.width ?? 0)
        rightView?.frame = CGRect(x: rightViewX, y: 0, width: 24, height: frame.height)
    }
    
    // MARK: - Actions
    
    @objc private func clearText() {
        text = ""
        sendActions(for: .editingChanged)
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        borderStyle = .none
        tintColor = Palette.black
        background = Images.textFieldBackgroundDefault
        setCustomClearButton()
    }
    
    private func setCustomClearButton() {
        let button = UIButton()
        button.setImage(Icons.crossSmall, for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        rightView = button
        rightViewMode = .whileEditing
    }
}
