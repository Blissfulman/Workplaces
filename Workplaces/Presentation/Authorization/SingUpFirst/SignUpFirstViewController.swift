//
//  SignUpFirstViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpFirstScreenCoordinable {
    var didTapNextButton: (() -> Void)? { get set }
    var didTapAlreadyRegisteredButton: (() -> Void)? { get set }
}

final class SignUpFirstViewController: UIViewController, SignUpFirstScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapNextButton: (() -> Void)?
    var didTapAlreadyRegisteredButton: (() -> Void)?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func nextButtonTapped() {
        didTapNextButton?()
    }
    
    @IBAction private func alreadyRegisteredButtonTapped() {
        didTapAlreadyRegisteredButton?()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Регистрация"
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
