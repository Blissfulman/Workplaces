//
//  NibInitializableView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.05.2021.
//

import UIKit

/// Родителский класс для всех переиспользуемых `UIView`, инициализируемых из `UINib`.
class NibInitializableView: UIView, NibInitializable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib(nibName: String(describing: Self.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
