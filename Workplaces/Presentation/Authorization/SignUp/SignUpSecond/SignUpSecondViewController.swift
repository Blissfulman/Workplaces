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
    
    @IBAction private func registerButtonTapped() {
        guard let email = userCredentials.email, !email.isEmpty,
              let password = userCredentials.password, !password.isEmpty else {
            showAlert("Необходимо было ввести email и пароль")
            return
        }
        
        let userCredentials = UserCredentials(email: email, password: password)
        
        LoadingView.show()
        let progress = authorizationService.registerUser(userCredentials: userCredentials) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case .success:
                self?.didTapRegisterButton?()
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
