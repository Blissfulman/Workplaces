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
    func didFinishSignUp()
}

final class SignUpContainerViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let authorizationService: AuthorizationService
    private let profileService: ProfileService
    private let signUpModel = SignUpModel()
    private var progressList = [Progress]()
    private lazy var signUpFirstVC = SignUpFirstViewController(signUpModel: signUpModel, delegate: self)
    
    // MARK: - Initializers
    
    init(
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService,
        profileService: ProfileService = ServiceLayer.shared.profileService,
        delegate: SignUpContainerViewControllerDelegate
    ) {
        self.authorizationService = authorizationService
        self.profileService = profileService
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        addFullover(signUpFirstVC)
    }
    
    private func handleAuthorizationError(_ error: Error) {
        guard let authError = error as? AuthorizationServiceError else { return }
        
        switch authError {
        case .emailValidationError:
            signUpFirstVC.indicateInvalidEmail()
        case .passwordValidationError:
            signUpFirstVC.indicateInvalidPassword()
        default:
            break
        }
        showAlert(authError)
    }
}

// MARK: - SignUpFirstViewControllerDelegate

extension SignUpContainerViewController: SignUpFirstViewControllerDelegate {
    
    func didTapSignUpButton() {
        LoadingView.show()
        let userCredentials = signUpModel.userCredentials
        
        let progress = authorizationService.signUpWithEmail(userCredentials: userCredentials) { [weak self] result in
            LoadingView.hide()
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.delegate?.goToSignUpSecondScreen(signUpModel: self.signUpModel, delegate: self)
            case let .failure(error):
                self.handleAuthorizationError(error)
            }
        }
        progressList.append(progress)
    }
    
    func didTapAlreadySignedUpButton() {
        delegate?.goToSignIn()
    }
}

// MARK: - SignUpSecondViewControllerDelegate

extension SignUpContainerViewController: SignUpSecondViewControllerDelegate {
    
    func didTapSaveButton() {
        let progress = profileService.updateMyProfile(user: signUpModel.updatedProfile) { _ in }
        progressList.append(progress)
        delegate?.didFinishSignUp()
    }
}
