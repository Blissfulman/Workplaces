//
//  SignInViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

protocol SignInScreenCoordinable {
    var didTapRegisterButton: (() -> Void)? { get set }
    var didTapEnterButton: (() -> Void)? { get set }
}

final class SignInViewController: UIViewController, SignInScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapRegisterButton: (() -> Void)?
    var didTapEnterButton: (() -> Void)?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func registerButtonTapped() {
        didTapRegisterButton?()
    }
    
    @IBAction private func enterButtonTapped() {
        didTapEnterButton?()
    }
    
//    @objc private func closeButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
    
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
}
