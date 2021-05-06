//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol LoginScreenCoordinable: AnyObject {
    func didTapSignInWithEmailButton()
    func didTapSignInWithGoogleButton()
    func didTapSignInWithFacebookButton()
    func didTapSignInWithVKButton()
    func didTapSignUpWithEmail()
}

final class LoginViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var coordinator: LoginScreenCoordinable?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func signInWithEmailButtonTapped() {
        coordinator?.didTapSignInWithEmailButton()
    }
    
    @IBAction private func signInWithGoogleTapped() {
        coordinator?.didTapSignInWithGoogleButton()
    }
    
    @IBAction private func signInWithFacebookTapped() {
        coordinator?.didTapSignInWithFacebookButton()
    }
    
    @IBAction private func signInWithVKTapped() {
        coordinator?.didTapSignInWithVKButton()
    }
    
    @IBAction private func signUpWithEmailTapped() {
        coordinator?.didTapSignUpWithEmail()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
    }
}
