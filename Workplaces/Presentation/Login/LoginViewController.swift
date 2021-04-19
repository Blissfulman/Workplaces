//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var enterButton: UIButton!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        enterButton.layer.cornerRadius = 14
    }
}
