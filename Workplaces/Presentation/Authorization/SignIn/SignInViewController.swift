//
//  SignInViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInViewControllerDelegate: AnyObject {
    func didTapSignUpButton()
    func didTapSignInButton()
}

final class SignInViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignInViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var enterButton: UIButton!
    @IBOutlet private weak var enterButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let signInModel: SignInModel
    
    // MARK: - Initializers
    
    init(signInModel: SignInModel, delegate: SignInViewControllerDelegate) {
        self.signInModel = signInModel
        self.delegate = delegate
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
        registerForKeyboardNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        if sender == emailTextField {
            signInModel.email = emailTextField.text
            updateEmailTextFieldState()
        } else {
            signInModel.password = passwordTextField.text
        }
        updateEnterButtonState()
    }
    
    @IBAction private func signUpButtonTapped() {
        delegate?.didTapSignUpButton()
    }
    
    @IBAction private func signInButtonTapped() {
        enterButton.scaleAnimation {
            self.delegate?.didTapSignInButton()
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = value.cgRectValue.height
        
        UIView.animate(withDuration: 0.5) {
            self.enterButtonBottomConstraint.constant = keyboardHeight + 16
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.5) {
            self.enterButtonBottomConstraint.constant = 44
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Private methods
    
    private func updateEnterButtonState() {
        enterButton.isEnabled = signInModel.isPossibleToSignIn
    }
    
    // MARK: - Private methods
    
    private func updateEmailTextFieldState() {
        emailTextField.textColor = signInModel.isValidEmail ? Palette.black : Palette.orange
        // Нужно будет добавить обновление подсветки поля на основе валидации e-mail
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
