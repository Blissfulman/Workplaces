//
//  SearchFriendsViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

final class SearchFriendsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var searchTextField: UITextField!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        searchTextField.leftView = UIImageView(image: Icons.close)
    }
}
