//
//  SignUpSecondViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpSecondScreenDelegate: AnyObject {
    func successfulSignUp()
}

final class SignUpSecondViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpSecondScreenDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var bithdayTextField: UITextField!
    
    // MARK: - Private properties
    
    private let userCredentials: UserCredentials
    private let authorizationService: AuthorizationService
    private var progressList = [Progress]()
    
    // MARK: - Initializers
    
    init(
        userCredentials: UserCredentials,
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService
    ) {
        self.userCredentials = userCredentials
        self.authorizationService = authorizationService
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpButtonTapped() {
        guard let email = userCredentials.email, !email.isEmpty,
              let password = userCredentials.password, !password.isEmpty else {
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
                self?.showAlert(error)
            }
        }
        progressList.append(progress)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Регистрация"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
