//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol LoginScreenCoordinable {
    var didTapEnterButton: (() -> Void)? { get set }
    var didTapRegistrationByEmail: (() -> Void)? { get set }
}

final class LoginViewController: UIViewController, LoginScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapEnterButton: (() -> Void)?
    var didTapRegistrationByEmail: (() -> Void)?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func enterButtonTapped() {
        didTapEnterButton?()
    }
    
    @IBAction private func registrationByEmailTapped() {
        didTapRegistrationByEmail?()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
    }
}
