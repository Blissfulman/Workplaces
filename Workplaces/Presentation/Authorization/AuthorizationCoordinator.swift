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
    
    private weak var navigationController: NavigationController?
    private let securityManager: SecurityManager
    
    // MARK: - Initializers
    
    init(
        navigationController: NavigationController,
        securityManager: SecurityManager = ServiceLayer.shared.securityManager,
        onFinish: @escaping VoidBlock
    ) {
        self.navigationController = navigationController
        self.securityManager = securityManager
        self.onFinish = onFinish
    }
    
    // MARK: - Public methods
    
    func start() {
        securityManager.isSavedRefreshToken ? showProtectionScreen(delegate: self) : showLoginScreen()
    }
    
    // MARK: - Private methods
    
    private func showLoginScreen() {
        let loginVC = LoginViewController(delegate: self)
        navigationController?.show(loginVC, sender: nil)
    }
    
    private func showSignInScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignInContainerViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signInContainerVC = SignInContainerViewController(delegate: self)
        navigationController?.show(signInContainerVC, sender: nil)
    }
    
    private func showProtectionScreen(delegate: ProtectionContainerViewControllerDelegate) {
        let protectionContainerVC = ProtectionContainerViewController(delegate: delegate)
        navigationController?.show(protectionContainerVC, sender: nil)
    }
    
    private func showSignUpContainerController() {
        guard navigationController?.viewControllers.first(where: { $0 is SignUpContainerViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signUpContainerVC = SignUpContainerViewController(delegate: self)
        navigationController?.show(signUpContainerVC, sender: nil)
    }
    
    private func showSignUpSecondScreen(signUpModel: SignUpModel, delegate: SignUpSecondViewControllerDelegate) {
        let signUpSecondVC = SignUpSecondViewController(signUpModel: signUpModel, delegate: delegate)
        navigationController?.show(signUpSecondVC, sender: nil)
    }
    
    private func showSignInDoneScreen() {
        let signInDoneVC = SignInDoneViewController(delegate: self)
        navigationController?.show(signInDoneVC, sender: nil)
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
    
    func didTapSignUpWithEmail() {
        showSignUpContainerController()
    }
}

// MARK: - SignInContainerViewControllerDelegate

extension AuthorizationCoordinatorImpl: SignInContainerViewControllerDelegate {
    
    func goToSignUp() {
        showSignUpContainerController()
    }
    
    func successfulSignIn(delegate: ProtectionContainerViewControllerDelegate) {
        showProtectionScreen(delegate: delegate)
    }
    
    func didCancelSetUpProtectionOnSignIn() {
        onFinish()
    }
    
    func didFinishSignIn() {
        showSignInDoneScreen()
    }
}

// MARK: - SignUpContainerViewControllerDelegate

extension AuthorizationCoordinatorImpl: SignUpContainerViewControllerDelegate {
    
    func goToSignIn() {
        showSignInScreen()
    }
    
    func successfulSignUp(delegate: ProtectionContainerViewControllerDelegate) {
        showProtectionScreen(delegate: delegate)
    }
    
    func didCancelSetUpProtectionOnSignUp() {
        onFinish()
    }
    
    func goToSignUpSecondScreen(signUpModel: SignUpModel, delegate: SignUpSecondViewControllerDelegate) {
        showSignUpSecondScreen(signUpModel: signUpModel, delegate: delegate)
    }
    
    func didFinishSignUp() {
        showSignInDoneScreen()
    }
}

// MARK: - SignInDoneScreenDelegate

extension AuthorizationCoordinatorImpl: SignInDoneScreenDelegate {
    
    func goToFeed() {
        showTabBarController()
    }
}

// MARK: - SignInDoneScreenDelegate

extension AuthorizationCoordinatorImpl: ProtectionContainerViewControllerDelegate {
    
    func didCancelSetUpProtection() {
        onFinish()
    }
    
    func didSetProtection() {}
    
    func didPassProtectionCheck() {
        onFinish()
    }
}
