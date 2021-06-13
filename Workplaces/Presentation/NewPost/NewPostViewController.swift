//
//  NewPostViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol NewPostViewControllerDelegate: AnyObject {
    
}

final class NewPostViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private weak var delegate: NewPostViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(delegate: NewPostViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
