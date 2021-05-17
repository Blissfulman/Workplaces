//
//  SearchFriendsViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol SearchFriendsViewControllerDelegate: AnyObject {
    func didTapSearchButton(query: String)
}

final class SearchFriendsViewController: UIViewController {
    
    private weak var delegate: SearchFriendsViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var searchTextField: UITextField!
    
    // MARK: - Initializers
    
    init(delegate: SearchFriendsViewControllerDelegate) {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction private func searchButtonTapped() {
        // TEMP
        delegate?.didTapSearchButton(query: searchTextField.text ?? "")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        searchTextField.leftView = UIImageView(image: Icons.close)
    }
}
