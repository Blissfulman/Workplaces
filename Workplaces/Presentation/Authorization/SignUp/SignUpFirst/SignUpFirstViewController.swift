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
    
    // MARK: - Public properties
    
    weak var delegate: SignUpFirstViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var signUpButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let signUpModel: SignUpModel
    
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
        let keyboardHeight = getKeyboardHeight(notification: notification)
        
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signUpButtonBottomConstraint.constant = keyboardHeight
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide() {
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signUpButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
            self.view.layoutIfNeeded()
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
        delegate?.didTapSignUpButton()
    }
    
    @IBAction private func alreadySignedUpButtonTapped() {
        delegate?.didTapAlreadySignedUpButton()
    }
    
    // MARK: - Private methods
    
    private func updateSignUpButtonState() {
        signUpButton.isEnabled = signUpModel.isPossibleToSignUp
    }
}
