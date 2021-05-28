//
//  BirthdayTextField.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 27.05.2021.
//

import UIKit.UIButton

final class BirthdayTextField: UITextField {
    
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
    
    // MARK: - Actions
    
    @objc private func calendarButtonTapped() {
        sendActions(for: .editingDidBegin)
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        borderStyle = .none
        tintColor = Palette.black
        background = Images.textFieldBackgroundDefault
        setCalendarButton()
    }
    
    private func setCalendarButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(Icons.calendar, for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }
}
