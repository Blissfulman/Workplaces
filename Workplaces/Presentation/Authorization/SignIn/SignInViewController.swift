//
//  SignInViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInScreenCoordinable {
    var didTapRegisterButton: VoidBlock? { get set }
    var didTapEnterButton: VoidBlock? { get set }
}

final class SignInViewController: UIViewController, SignInScreenCoordinable {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailOrLoginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var enterButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Public properties
    
    var didTapRegisterButton: VoidBlock?
    var didTapEnterButton: VoidBlock?
    
    // MARK: - Private properties
    
    private let authorizationService: AuthorizationService
    
    // MARK: - Initializers
    
    init(authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService) {
        self.authorizationService = authorizationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerForKeyboardNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction private func registerButtonTapped() {
        didTapRegisterButton?()
    }
    
    @IBAction private func enterButtonTapped() {
        guard let email = emailOrLoginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else { return }
        
        LoadingView.show()
        authorizationService.signIn(withEmail: email, andPassword: password) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case .success:
                print("Успешная авторизация!")
                self?.didTapEnterButton?()
            case let .failure(error):
                self?.showAlert(error)
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        // Временно захардкожено, не уделял пока этому время
        enterButtonBottomConstraint.constant = 16 + keyboardFrame.height
    }
    
    @objc private func keyboardWillHide() {
        enterButtonBottomConstraint.constant = 16
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Вход по почте"
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
