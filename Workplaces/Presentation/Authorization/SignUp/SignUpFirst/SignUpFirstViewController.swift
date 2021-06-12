//
//  SignUpFirstViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpFirstViewControllerDelegate: AnyObject {
    func didTapSignUpButton()
    func didTapAlreadySignedUpButton()
}

final class SignUpFirstViewController: KeyboardNotificationsViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var signUpButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let signUpModel: SignUpModel
    private weak var delegate: SignUpFirstViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(signUpModel: SignUpModel, delegate: SignUpFirstViewControllerDelegate) {
        self.signUpModel = signUpModel
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
            self.signUpButtonBottomConstraint.constant = keyboardFrame.height
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { _ in
            self.signUpButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
        }
    }
    
    // MARK: - Public methods
    
    /// Отображает анимацию поля ввода email, сообщающую о некорректно введённых данных.
    func indicateToIncorrectEmail() {
        emailTextField.textColor = Palette.orange
        emailTextField.background = Images.textFieldBackgroundAccent
        emailTextField.shakeAnimation()
    }
    
    /// Отображает анимацию поля ввода пароля, сообщающую о некорректно введённых данных.
    func indicateToIncorrectPassword() {
        passwordTextField.textColor = Palette.orange
        passwordTextField.background = Images.textFieldBackgroundAccent
        passwordTextField.shakeAnimation()
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        if sender == emailTextField {
            emailTextField.textColor = Palette.black
            emailTextField.background = Images.textFieldBackgroundDefault
            signUpModel.email = emailTextField.text
        }
        if sender == passwordTextField {
            passwordTextField.textColor = Palette.black
            passwordTextField.background = Images.textFieldBackgroundDefault
            signUpModel.password = passwordTextField.text
        }
        updateSignUpButtonState()
    }
    
    @IBAction private func signUpButtonTapped() {
        view.endEditing(true)
        delegate?.didTapSignUpButton()
    }
    
    @IBAction private func alreadySignedUpButtonTapped() {
        view.endEditing(true)
        delegate?.didTapAlreadySignedUpButton()
    }
    
    // MARK: - Private methods
    
    private func updateSignUpButtonState() {
        signUpButton.isEnabled = signUpModel.isPossibleToSignUp
    }
}

// MARK: - Text field delegate

extension SignUpFirstViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            signUpButtonTapped()
            textField.resignFirstResponder()
        }
        return true
    }
}
