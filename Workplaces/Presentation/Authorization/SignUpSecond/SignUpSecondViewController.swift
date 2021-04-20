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
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var bithdayTextField: UITextField!
    @IBOutlet private weak var cityTextField: UITextField!
    
    // MARK: - Private properties
    
    private let userFirstScreen: User
    private let passwordFirstScreen: String?
    private let authorizationService = ServiceLayer.shared.authorizationService
    
    // MARK: - Initializers
    
    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, user: User, password: String?) {
        self.userFirstScreen = user
        self.passwordFirstScreen = password
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        guard let email = userFirstScreen.email, !email.isEmpty,
              let password = passwordFirstScreen, !password.isEmpty else {
            showAlert("Необходимо было ввести email и пароль")
            return
        }
        
        authorizationService.registerUser(withEmail: email, andPassword: password) { [weak self] result in
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
