//
//  ZeroView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

final class ZeroView: NibInitializableView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Private properties
    
    private var buttonAction: VoidBlock?
    
    // MARK: - Initializers
    
    convenience init(model: ZeroViewModel, buttonAction: VoidBlock? = nil) {
        self.init(frame: .zero)
        self.buttonAction = buttonAction
        configure(model: model, buttonAction: buttonAction)
    }
    
    // MARK: - Actions
    
    @IBAction private func buttonTapped() {
        buttonAction?()
    }
    
    // MARK: - Private methods
    
    private func configure(model: ZeroViewModel, buttonAction: VoidBlock? = nil) {
        imageView.image = model.image
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        button.setTitle(model.buttonTitle, for: .normal)
        
        if buttonAction != nil {
            button.isHidden = false
        }
    }
}
