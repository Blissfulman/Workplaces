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
    
    // MARK: - Private properties
    
    private var isValidEnteredEmail: Bool {
        EmailValidator.isValid(emailTextField.text)
    }
    
    // MARK: - UIViewController
    
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
}
