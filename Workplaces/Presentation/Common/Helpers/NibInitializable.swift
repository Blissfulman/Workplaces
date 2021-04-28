//
//  NibInitializable.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

protocol NibInitializable {}

extension NibInitializable where Self: UIView {
    
    // MARK: - Static methods
    
    static func initializeFromNib() -> Self {
        let nib = UINib(nibName: String(describing: Self.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Failed to instantiate \(String(describing: Self.self))")
        }
        return view
    }
}
