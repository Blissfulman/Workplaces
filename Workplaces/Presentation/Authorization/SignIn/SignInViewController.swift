//
//  SignInViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInScreenDelegate: AnyObject {
    func goToSignUp()
    func successfulSignIn()
}

final class SignInViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignInScreenDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var enterButton: UIButton!
    @IBOutlet private weak var enterButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let authorizationService: AuthorizationService
    private var progressList = [Progress]()
    private var isEmptyAtLeastOneTextField: Bool {
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            return false
        } else {
            return true
        }
    }
    private var isValidEnteredEmail: Bool {
        EmailValidator.isValid(emailTextField.text)
    }
    
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
        progressList.forEach { $0.cancel() }
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
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        if sender == emailTextField {
            emailTextField.textColor = isValidEnteredEmail ? Palette.black : Palette.orange
            // Нужно будет добавить обновление подсветки поля на основе валидации e-mail
        }
        updateEnterButtonState()
    }
    
    @IBAction private func signUpButtonTapped() {
        delegate?.goToSignUp()
    }
    
    @IBAction private func signInButtonTapped() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        let userCredentials = UserCredentials(email: email, password: password)
        
        LoadingView.show()
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
        title = "Sign in with email".localized()
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func updateEnterButtonState() {
        enterButton.isEnabled = !isEmptyAtLeastOneTextField && isValidEnteredEmail
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
