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
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    // MARK: - UIButton
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            isHighlighted ? downscaleAnimation(scale: 0.93) : resetScaleAnimation()
        }
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        backgroundColor = Palette.grey
        tintColor = Palette.black
        titleLabel?.font = Fonts.title
        isExclusiveTouch = true
    }
}
