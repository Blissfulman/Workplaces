//
//  AuthorizationCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit
import WorkplacesAPI

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
        
        loginVC.didTapEnterButton = { [weak self] in
            self?.showSignInScreen()
        }
        
        loginVC.didTapEnterByGoogleButton = {
            
        }
        
        loginVC.didTapEnterByFacebookButton = { [weak self] in
            // Test
            let newZeroScreen = ZeroViewController(viewType: .noData)
            self?.navigationController?.pushViewController(newZeroScreen, animated: true)
        }
        
        loginVC.didTapEnterByVKButton = { [weak self] in
            // Test
            let newZeroScreen = ZeroViewController(viewType: .error) {
                print("Tap")
            }
            self?.navigationController?.pushViewController(newZeroScreen, animated: true)
        }
        
        loginVC.didTapSignUpByEmail = { [weak self] in
            self?.showSignUpFirstScreen()
        }
        
        navigationController?.pushViewController(loginVC, animated: false)
    }
    
    private func showSignInScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignInViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signInVC = SignInViewController()
        
        signInVC.didTapEnterButton = { [weak self] in
            self?.showSignInDoneScreen()
        }
        
        signInVC.didTapRegisterButton = { [weak self] in
            self?.showSignUpFirstScreen()
        }
        
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func showSignInDoneScreen() {
        let signInDoneVC = SignInDoneViewController()
        
        signInDoneVC.didTapToFeedButton = { [weak self] in
            self?.showTabBarController()
        }
        
        navigationController?.pushViewController(signInDoneVC, animated: true)
    }
    
    private func showSignUpFirstScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignUpFirstViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signUpFirstVC = SignUpFirstViewController()
        
        signUpFirstVC.didTapNextButton = { [weak self] credentialData in
            self?.showSignUpSecondScreen(credentialData: credentialData)
        }
        
        signUpFirstVC.didTapAlreadyRegisteredButton = { [weak self] in
            self?.showSignInScreen()
        }
        
        navigationController?.pushViewController(signUpFirstVC, animated: true)
    }
    
    private func showSignUpSecondScreen(credentialData: CredentialData) {
        let signUpSecondVC = SignUpSecondViewController(credentialData: credentialData)
        
        signUpSecondVC.didTapRegisterButton = { [weak self] in
            self?.showSignInDoneScreen()
        }
        
        navigationController?.pushViewController(signUpSecondVC, animated: true)
    }
    
    private func showTabBarController() {
        onFinish()
    }
}
