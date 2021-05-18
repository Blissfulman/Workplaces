//
//  SignUpFirstViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpFirstViewControllerDelegate: AnyObject {
    func didTapNextButton()
    func didTapSignInButton()
}

final class SignUpFirstViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpFirstViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var alreadySignedUpButtonBottomConstraint: NSLayoutConstraint!
    
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
        switch sender {
        case nicknameTextField:
            signUpModel.nickname = nicknameTextField.text
        case emailTextField:
            signUpModel.email = emailTextField.text
            updateEmailTextFieldState()
        case passwordTextField:
            signUpModel.password = passwordTextField.text
            updatePasswordTextFieldState()
        default:
            break
        }
    }
    
    @IBAction private func forwardNextTapped() {
        signUpModel.nickname = nicknameTextField.text
        signUpModel.email = emailTextField.text
        signUpModel.password = passwordTextField.text
        delegate?.didTapNextButton()
    }
    
    @IBAction private func alreadySignedUpButtonTapped() {
        delegate?.didTapSignInButton()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = value.cgRectValue.height
        
        UIView.animate(withDuration: 0.5) {
            self.alreadySignedUpButtonBottomConstraint.constant = keyboardHeight
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.5) {
            self.alreadySignedUpButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Private methods
    
    private func updateEmailTextFieldState() {
        emailTextField.textColor = signUpModel.isValidEmail ? Palette.black : Palette.orange
    }
    
    private func updatePasswordTextFieldState() {
        passwordTextField.textColor = signUpModel.isValidPassword ? Palette.black : Palette.orange
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
