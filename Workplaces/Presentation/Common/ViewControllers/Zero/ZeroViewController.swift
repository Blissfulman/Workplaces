//
//  ZeroViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

final class ZeroViewController: UIViewController {
    
    init(viewType: ZeroView.ViewType, buttonAction: VoidBlock? = nil) {
        super.init(nibName: nil, bundle: nil)
        view = ZeroView(viewType: viewType, buttonAction: buttonAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
