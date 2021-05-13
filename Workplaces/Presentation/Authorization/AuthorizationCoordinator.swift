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
    
    private func showSignUpContainerController() {
        guard navigationController?.viewControllers.first(where: { $0 is SignUpContainerController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signUpContainerController = SignUpContainerController(delegate: self)
        navigationController?.pushViewController(signUpContainerController, animated: true)
    }
    
    private func showSignUpSecondScreen(signUpModel: SignUpModel, delegate: SignUpSecondViewControllerDelegate) {
        let signUpSecondVC = SignUpSecondViewController(signUpModel: signUpModel, delegate: delegate)
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
        showSignUpContainerController()
    }
}

// MARK: - SignInScreenDelegate

extension AuthorizationCoordinatorImpl: SignInScreenDelegate {
    
    func goToSignUp() {
        showSignUpContainerController()
    }
    
    func successfulSignIn() {
        showSignInDoneScreen()
    }
}

// MARK: - SignUpContainerControllerDelegate

extension AuthorizationCoordinatorImpl: SignUpContainerControllerDelegate {
    
    func goToSignUpSecondScreen(signUpModel: SignUpModel, delegate: SignUpSecondViewControllerDelegate) {
        showSignUpSecondScreen(signUpModel: signUpModel, delegate: delegate)
    }
    
    func goToSignIn() {
        showSignInScreen()
    }
    
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
