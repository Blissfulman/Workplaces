//
//  NibInitializable.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

protocol NibInitializable {}

extension NibInitializable where Self: UIView {
    
    func initFromNib(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("Failed to instantiate \(nibName)")
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
