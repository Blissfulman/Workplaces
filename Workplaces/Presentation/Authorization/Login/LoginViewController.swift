//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol LoginScreenCoordinable {
    var didTapSignInWithEmailButton: VoidBlock? { get set }
    var didTapSignInWithGoogleButton: VoidBlock? { get set }
    var didTapSignInWithFacebookButton: VoidBlock? { get set }
    var didTapSignInWithVKButton: VoidBlock? { get set }
    var didTapSignUpWithEmail: VoidBlock? { get set }
}

final class LoginViewController: UIViewController, LoginScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapSignInWithEmailButton: VoidBlock?
    var didTapSignInWithGoogleButton: VoidBlock?
    var didTapSignInWithFacebookButton: VoidBlock?
    var didTapSignInWithVKButton: VoidBlock?
    var didTapSignUpWithEmail: VoidBlock?
    
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
        didTapSignInWithEmailButton?()
    }
    
    @IBAction private func enterWithGoogleTapped() {
        didTapSignInWithGoogleButton?()
    }
    
    @IBAction private func enterWithFacebookTapped() {
        didTapSignInWithFacebookButton?()
    }
    
    @IBAction private func enterWithVKTapped() {
        didTapSignInWithVKButton?()
    }
    
    @IBAction private func signUpWithEmailTapped() {
        didTapSignUpWithEmail?()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
    }
}
