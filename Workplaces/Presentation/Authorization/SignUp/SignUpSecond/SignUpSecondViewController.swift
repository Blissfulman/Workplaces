//
//  SignUpSecondViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpSecondScreenCoordinable {
    var didTapRegisterButton: VoidBlock? { get set }
}

final class SignUpSecondViewController: UIViewController, SignUpSecondScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapRegisterButton: VoidBlock?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var secondNameTextField: UITextField!
    @IBOutlet private weak var bithdayTextField: UITextField!
    
    // MARK: - Private properties
    
    private let credentialData: CredentialData
    private let authorizationService: AuthorizationService
    
    // MARK: - Initializers
    
    init(credentialData: CredentialData,
         authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService
    ) {
        self.credentialData = credentialData
        self.authorizationService = authorizationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction private func registerButtonTapped() {
        guard let email = credentialData.email, !email.isEmpty,
              let password = credentialData.password, !password.isEmpty else {
            showAlert("Необходимо было ввести email и пароль")
            return
        }
        
        LoadingView.show()
        authorizationService.registerUser(withEmail: email, andPassword: password) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case .success:
                self?.didTapRegisterButton?()
            case let .failure(error):
                self?.showAlert(error)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Регистрация"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
