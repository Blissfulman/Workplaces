//
//  SignInDoneViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInDoneScreenCoordinable {
    var didTapToFeedButton: VoidBlock? { get set }
}

final class SignInDoneViewController: UIViewController, SignInDoneScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapToFeedButton: VoidBlock?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func toFeedButtonTapped() {
        didTapToFeedButton?()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
