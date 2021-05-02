//
//  FindFriendsViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

final class FindFriendsViewController: UIViewController {
    
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
        navigationItem.title = "Поиск друзей"
    }
}
