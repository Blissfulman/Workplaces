//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var enterButton: CustomButton!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction private func enterButtonTapped() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
    }
}
