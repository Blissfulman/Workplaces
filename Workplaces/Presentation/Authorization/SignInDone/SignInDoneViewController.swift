//
//  SignInDoneViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInDoneScreenDelegate: AnyObject {
    func goToFeed()
}

final class SignInDoneViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignInDoneScreenDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func goToFeedButtonTapped() {
        delegate?.goToFeed()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
