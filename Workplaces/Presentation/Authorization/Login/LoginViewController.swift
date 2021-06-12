//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol LoginScreenDelegate: AnyObject {
    func didTapSignInWithEmailButton()
    func didTapSignInWithGoogleButton()
    func didTapSignInWithFacebookButton()
    func didTapSignInWithVKButton()
    func didTapSignUpWithEmail()
}

final class LoginViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private weak var delegate: LoginScreenDelegate?
    
    // MARK: - Initializers
    
    init(delegate: LoginScreenDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func signInWithEmailButtonTapped() {
        delegate?.didTapSignInWithEmailButton()
    }
    
    @IBAction private func signInWithGoogleTapped() {
        delegate?.didTapSignInWithGoogleButton()
    }
    
    @IBAction private func signInWithFacebookTapped() {
        delegate?.didTapSignInWithFacebookButton()
    }
    
    @IBAction private func signInWithVKTapped() {
        delegate?.didTapSignInWithVKButton()
    }
    
    @IBAction private func signUpWithEmailTapped() {
        delegate?.didTapSignUpWithEmail()
    }
}
