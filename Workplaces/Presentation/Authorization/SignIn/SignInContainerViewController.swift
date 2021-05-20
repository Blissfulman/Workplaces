//
//  SignInContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 14.05.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInContainerViewControllerDelegate: AnyObject {
    func goToSignUp()
    func successfulSignIn()
}

final class SignInContainerViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let authorizationService: AuthorizationService
    private let signInModel = SignInModel()
    private var progressList = [Progress]()
    private weak var delegate: SignInContainerViewControllerDelegate?
    private lazy var signInVC = SignInViewController(signInModel: signInModel, delegate: self)
    
    // MARK: - Initializers
    
    init(
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService,
        delegate: SignInContainerViewControllerDelegate
    ) {
        self.authorizationService = authorizationService
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        progressList.forEach { $0.cancel() }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Sign in".localized()
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        addFullover(signInVC)
    }
}

// MARK: - SignInViewControllerDelegate

extension SignInContainerViewController: SignInViewControllerDelegate {
    
    func didTapSignUpButton() {
        delegate?.goToSignUp()
    }
    
    func didTapSignInButton() {
        LoadingView.show()
        let userCredentials = signInModel.userCredentials
        
        let progress = authorizationService.signInWithEmail(userCredentials: userCredentials) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case .success:
                self?.delegate?.successfulSignIn()
            case let .failure(error):
                self?.showAlert(error)
            }
        }
        progressList.append(progress)
    }
}
