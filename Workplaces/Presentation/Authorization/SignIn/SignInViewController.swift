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
            updatePasswordTextFieldState()
        }
        updateSignInButtonState()
    }
    
    @IBAction private func signUpButtonTapped() {
        delegate?.didTapSignUpButton()
    }
    
    @IBAction private func signInButtonTapped() {
        guard signInModel.isValidEmail && signInModel.isValidPassword else {
            if !signInModel.isValidEmail {
                emailTextField.shakeAnimation()
            }
            if !signInModel.isValidPassword {
                passwordTextField.shakeAnimation()
            }
            return
        }
        delegate?.didTapSignInButton()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = value.cgRectValue.height
        
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signInButtonBottomConstraint.constant = keyboardHeight
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signInButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Private methods
    
    private func updateSignInButtonState() {
        signInButton.isEnabled = signInModel.isPossibleToSignIn
    }
    
    // MARK: - Private methods
    
    private func updateEmailTextFieldState() {
        emailTextField.textColor = signInModel.isValidEmail ? Palette.black : Palette.orange
    }
    
    private func updatePasswordTextFieldState() {
        passwordTextField.textColor = signInModel.isValidPassword ? Palette.black : Palette.orange
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
