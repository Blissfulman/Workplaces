//
//  SignInDoneViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInDoneScreenCoordinable: AnyObject {
    func goToFeed()
}

final class SignInDoneViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var coordinator: SignInDoneScreenCoordinable?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func goToFeedButtonTapped() {
        coordinator?.goToFeed()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
