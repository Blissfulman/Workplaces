//
//  SignInViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

final class SignInViewController: UIViewController {

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Вход по почте"
        navigationController?.setNavigationBarHidden(false, animated: true)
//        let backBarButtonItem = UIBarButtonItem(image: Icons.crossSmall,
//                                                style: .plain,
//                                                target: self,
//                                                action: #selector(closeButtonTapped))
//        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    // MARK: - IBActions
    
    @IBAction private func enterButtonTapped() {
        let signInDoneVC = SignInDoneViewController()
        navigationController?.pushViewController(signInDoneVC, animated: true)
    }
    
    @objc private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
