//
//  AuthorizationCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol AuthorizationCoordinator: Coordinator {}

final class AuthorizationCoordinatorImpl: AuthorizationCoordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, onFinish: @escaping VoidBlock) {
        self.navigationController = navigationController
        self.onFinish = onFinish
    }
    
    // MARK: - Public methods
    
    func start() {
        showLoginScreen()
    }
    
    // MARK: - Private methods
    
    private func showLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.delegate = self
        navigationController?.pushViewController(loginVC, animated: false)
    }
    
    private func showSignInScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignInViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signInVC = SignInViewController()
        signInVC.delegate = self
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func showSignUpFirstScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignUpFirstViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signUpFirstVC = SignUpFirstViewController()
        signUpFirstVC.delegate = self
        navigationController?.pushViewController(signUpFirstVC, animated: true)
    }
    
    private func showSignUpSecondScreen(userCredentials: UserCredentials) {
        let signUpSecondVC = SignUpSecondViewController(userCredentials: userCredentials)
        signUpSecondVC.delegate = self
        navigationController?.pushViewController(signUpSecondVC, animated: true)
    }
    
    private func showSignInDoneScreen() {
        let signInDoneVC = SignInDoneViewController()
        signInDoneVC.delegate = self
        navigationController?.pushViewController(signInDoneVC, animated: true)
    }
    
    private func showTabBarController() {
        onFinish()
    }
}

// MARK: - LoginScreenDelegate

extension AuthorizationCoordinatorImpl: LoginScreenDelegate {
    
    func didTapSignInWithEmailButton() {
        showSignInScreen()
    }
    
    func didTapSignInWithGoogleButton() {}
    
    func didTapSignInWithFacebookButton() {}
    
    func didTapSignInWithVKButton() {}
    
    func didTapSignUpWithEmail() {
        showSignUpFirstScreen()
    }
}

// MARK: - SignInScreenDelegate

extension AuthorizationCoordinatorImpl: SignInScreenDelegate {
    
    func goToSignUp() {
        showSignUpFirstScreen()
    }
    
    func successfulSignIn() {
        showSignInDoneScreen()
    }
}

// MARK: - SignUpFirstScreenDelegate

extension AuthorizationCoordinatorImpl: SignUpFirstScreenDelegate {
    
    func didTapNextButton(userCredentials: UserCredentials) {
        showSignUpSecondScreen(userCredentials: userCredentials)
    }
    
    func goToSignIn() {
        showSignInScreen()
    }
}

// MARK: - SignUpSecondScreenDelegate

extension AuthorizationCoordinatorImpl: SignUpSecondScreenDelegate {
    
    func successfulSignUp() {
        showSignInDoneScreen()
    }
}

// MARK: - SignInDoneScreenDelegate

extension AuthorizationCoordinatorImpl: SignInDoneScreenDelegate {
    
    func goToFeed() {
        showTabBarController()
    }
}
