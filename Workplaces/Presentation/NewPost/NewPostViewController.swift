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
    private var progressList = [Progress]()
    
    // MARK: - Initializers
    
    init(newPostService: NewPostService = NewPostServiceImpl(apiClient: ServiceLayer.shared.apiClient)) {
        self.newPostService = newPostService
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
        
    }
}
