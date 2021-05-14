//
//  SignUpContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.05.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpContainerViewControllerDelegate: AnyObject {
    func goToSignUpSecondScreen(signUpModel: SignUpModel, delegate: SignUpSecondViewControllerDelegate)
    func goToSignIn()
    func successfulSignUp()
}

final class SignUpContainerViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let authorizationService: AuthorizationService
    private let signUpModel = SignUpModel()
    private var progressList = [Progress]()
    private lazy var signUpFirstVC: SignUpFirstViewController = {
        let signUpFirstVC = SignUpFirstViewController(signUpModel: signUpModel, delegate: self)
        signUpFirstVC.view.frame = view.bounds
        return signUpFirstVC
    }()
    
    // MARK: - Initializers
    
    init(
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService,
        delegate: SignUpContainerViewControllerDelegate
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
        title = "Sign up".localized()
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        add(signUpFirstVC)
    }
}

// MARK: - SignUpFirstViewControllerDelegate

extension SignUpContainerViewController: SignUpFirstViewControllerDelegate {
    
    func didTapNextButton() {
        delegate?.goToSignUpSecondScreen(signUpModel: signUpModel, delegate: self)
    }
    
    func didTapSignInButton() {
        delegate?.goToSignIn()
    }
}

// MARK: - SignUpSecondViewControllerDelegate

extension SignUpContainerViewController: SignUpSecondViewControllerDelegate {
    
    func didTapSignUpButton() {
        guard let email = signUpModel.email, !email.isEmpty,
              let password = signUpModel.password, !password.isEmpty else {
            showAlert("Необходимо было ввести e-mail и пароль") // TEMP
            return
        }
        let userCredentials = UserCredentials(email: email, password: password)
        
        LoadingView.show()
        let progress = authorizationService.signUpWithEmail(userCredentials: userCredentials) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case .success:
                self?.delegate?.successfulSignUp()
            case let .failure(error):
                self?.signUpFirstVC.showAlert(error)
            }
        }
        progressList.append(progress)
    }
}
