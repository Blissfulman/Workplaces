//
//  PinNumberButton.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 03.06.2021.
//

import UIKit

final class PinNumberButton: UIButton {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - UIButton
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            isHighlighted ? downscaleAnimation(duration: 0.1, scale: 0.9) : resetScaleAnimation(duration: 0.1)
        }
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        backgroundColor = .clear
        tintColor = Palette.black
        titleLabel?.font = Fonts.title
        isExclusiveTouch = true
    }
}
