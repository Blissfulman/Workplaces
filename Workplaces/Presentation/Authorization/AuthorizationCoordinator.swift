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
        loginVC.coordinator = self
        navigationController?.pushViewController(loginVC, animated: false)
    }
    
    private func showSignInScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignInViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signInVC = SignInViewController()
        signInVC.coordinator = self
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func showSignUpFirstScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignUpFirstViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signUpFirstVC = SignUpFirstViewController()
        signUpFirstVC.coordinator = self
        navigationController?.pushViewController(signUpFirstVC, animated: true)
    }
    
    private func showSignUpSecondScreen(userCredentials: UserCredentials) {
        let signUpSecondVC = SignUpSecondViewController(userCredentials: userCredentials)
        signUpSecondVC.coordinator = self
        navigationController?.pushViewController(signUpSecondVC, animated: true)
    }
    
    private func showSignInDoneScreen() {
        let signInDoneVC = SignInDoneViewController()
        signInDoneVC.coordinator = self
        navigationController?.pushViewController(signInDoneVC, animated: true)
    }
    
    private func showTabBarController() {
        onFinish()
    }
}

// MARK: - LoginScreenCoordinable

extension AuthorizationCoordinatorImpl: LoginScreenCoordinable {
    
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

// MARK: - SignInScreenCoordinable

extension AuthorizationCoordinatorImpl: SignInScreenCoordinable {
    
    func goToSignUp() {
        showSignUpFirstScreen()
    }
    
    func successfulSignIn() {
        showSignInDoneScreen()
    }
}

// MARK: - SignUpFirstScreenCoordinable

extension AuthorizationCoordinatorImpl: SignUpFirstScreenCoordinable {
    
    func didTapForwardButton(userCredentials: UserCredentials) {
        showSignUpSecondScreen(userCredentials: userCredentials)
    }
    
    func goToSignIn() {
        showSignInScreen()
    }
}

// MARK: - SignUpSecondScreenCoordinable

extension AuthorizationCoordinatorImpl: SignUpSecondScreenCoordinable {
    
    func successfulSignUp() {
        showSignInDoneScreen()
    }
}

// MARK: - SignInDoneScreenCoordinable

extension AuthorizationCoordinatorImpl: SignInDoneScreenCoordinable {
    
    func goToFeed() {
        showTabBarController()
    }
}
