//
//  NewPostViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class NewPostViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let newPostService: NewPostService
    private let authorizationService: AuthorizationService // Добавлен временно для тестирования
    private var progressList = [Progress]()
    
    // MARK: - Initializers
    
    init(
        newPostService: NewPostService = ServiceLayer.shared.newPostService,
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService
    ) {
        self.newPostService = newPostService
        self.authorizationService = authorizationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        progressList.forEach { $0.cancel() }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        // Test
        authorizationService.refreshToken { [weak self] result in
            switch result {
            case .success:
                print("Token refreshed successful")
            case let .failure(error):
                self?.showAlert(error)
            }
        }
    }
}
