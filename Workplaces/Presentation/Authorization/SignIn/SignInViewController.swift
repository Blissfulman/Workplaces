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

final class SignInViewController: KeyboardNotificationsViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var signInButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let signInModel: SignInModel
    private weak var delegate: SignInViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(signInModel: SignInModel, delegate: SignInViewControllerDelegate) {
        self.signInModel = signInModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - KeyboardNotificationsViewController
    
    override func keyboardWillShow(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { keyboardFrame in
            self.signInButtonBottomConstraint.constant = keyboardFrame.height
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { _ in
            self.signInButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        if sender == emailTextField {
            signInModel.email = emailTextField.text
        }
        if sender == passwordTextField {
            signInModel.password = passwordTextField.text
        }
        updateSignInButtonState()
    }
    
    @IBAction private func signUpButtonTapped() {
        view.endEditing(true)
        delegate?.didTapSignUpButton()
    }
    
    @IBAction private func signInButtonTapped() {
        view.endEditing(true)
        delegate?.didTapSignInButton()
    }
    
    // MARK: - Private methods
    
    private func updateSignInButtonState() {
        signInButton.isEnabled = signInModel.isPossibleToSignIn
    }
}

// MARK: - Text field delegate

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            signInButtonTapped()
            textField.resignFirstResponder()
        }
        return true
    }
}
