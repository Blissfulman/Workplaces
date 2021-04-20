//
//  FeedViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let authorizationService = ServiceLayer.shared.authorizationService
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func signOut() {
        authorizationService.signOut { [weak self] error in
            self?.showAlert(error)
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Популярное"
    }
}
