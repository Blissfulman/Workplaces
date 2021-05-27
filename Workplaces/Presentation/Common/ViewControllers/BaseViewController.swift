//
//  BaseViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 27.05.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
}
