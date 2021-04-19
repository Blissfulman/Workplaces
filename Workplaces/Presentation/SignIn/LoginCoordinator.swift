//
//  LoginCoordinator.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func start()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    
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
        loginVC.didTapRegistrationByEmail = {
            print("Registration by E-mail...")
        }
        navigationController?.pushViewController(loginVC, animated: false)
    }
    
    private func showSignInScreen() {
        let signInVC = SignInViewController()
        signInVC.didTapEnterButton = { [weak self] in
            self?.showSignInDoneScreen()
        }
        signInVC.didTapRegisterButton = {
            print("Registration...")
        }
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func showSignInDoneScreen() {
        let signInDoneVC = SignInDoneViewController()
        signInDoneVC.didTapToFeedButton = {
            print("Go to feed")
        }
        navigationController?.pushViewController(signInDoneVC, animated: true)
    }
}
