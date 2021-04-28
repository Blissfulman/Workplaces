//
//  LoginViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol LoginScreenCoordinable {
    var didTapEnterButton: VoidBlock? { get set }
    var didTapEnterByGoogleButton: VoidBlock? { get set }
    var didTapEnterByFacebookButton: VoidBlock? { get set }
    var didTapEnterByVKButton: VoidBlock? { get set }
    var didTapSignUpByEmail: VoidBlock? { get set }
}

final class LoginViewController: UIViewController, LoginScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapEnterButton: VoidBlock?
    var didTapEnterByGoogleButton: VoidBlock?
    var didTapEnterByFacebookButton: VoidBlock?
    var didTapEnterByVKButton: VoidBlock?
    var didTapSignUpByEmail: VoidBlock?
    
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
    
    @IBAction private func enterButtonTapped() {
        didTapEnterButton?()
    }
    
    @IBAction private func enterByGoogleTapped() {
        didTapEnterByGoogleButton?()
    }
    
    @IBAction private func enterByFacebookTapped() {
        didTapEnterByFacebookButton?()
    }
    
    @IBAction private func enterByVKTapped() {
        didTapEnterByVKButton?()
    }
    
    @IBAction private func signUpByEmailTapped() {
        didTapSignUpByEmail?()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
    }
}
