//
//  AuthorizationCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol AuthorizationCoordinator {
    func start()
}

final class AuthorizationCoordinatorImpl: AuthorizationCoordinator {
    
    // MARK: - Private properties
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        loginVC.didTapRegistrationByEmail = { [weak self] in
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
        signInDoneVC.didTapToFeedButton = {
            print("Переход к ленте...")
        }
        navigationController?.pushViewController(signInDoneVC, animated: true)
    }
    
    private func showSignUpFirstScreen() {
        guard navigationController?.viewControllers.first(where: { $0 is SignUpFirstViewController }) == nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let signUpFirstVC = SignUpFirstViewController()
        signUpFirstVC.didTapNextButton = { [weak self] user, password in
            self?.showSignUpSecondScreen(user: user, password: password)
        }
        signUpFirstVC.didTapAlreadyRegisteredButton = { [weak self] in
            self?.showSignInScreen()
        }
        navigationController?.pushViewController(signUpFirstVC, animated: true)
    }
    
    private func showSignUpSecondScreen(user: User, password: String?) {
        let signUpSecondVC = SignUpSecondViewController(user: user, password: password)
        signUpSecondVC.didTapRegisterButton = {
            print("Регистрация прошла успешно!")
        }
        navigationController?.pushViewController(signUpSecondVC, animated: true)
    }
}
