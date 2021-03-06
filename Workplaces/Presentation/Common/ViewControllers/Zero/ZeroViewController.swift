//
//  ZeroViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

final class ZeroViewController: BaseViewController {
    
    // MARK: - Initializers
    
    init(model: ZeroViewModel, buttonAction: VoidBlock? = nil) {
        super.init(nibName: nil, bundle: nil)
        view = ZeroView(model: model, buttonAction: buttonAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
