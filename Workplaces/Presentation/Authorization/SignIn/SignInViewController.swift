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
    
    // MARK: - Public properties
    
    weak var delegate: SignInViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signInButtonBottomConstraint: NSLayoutConstraint!
    
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
    
    // MARK: - UIViewController
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - KeyboardNotificationsViewController
    
    override func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification: notification)
        
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signInButtonBottomConstraint.constant = keyboardHeight
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide() {
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signInButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
            self.view.layoutIfNeeded()
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
        delegate?.didTapSignUpButton()
    }
    
    @IBAction private func signInButtonTapped() {
        delegate?.didTapSignInButton()
    }
    
    // MARK: - Private methods
    
    private func updateSignInButtonState() {
        signInButton.isEnabled = signInModel.isPossibleToSignIn
    }
}
