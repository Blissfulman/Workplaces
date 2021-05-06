//
//  SignUpFirstViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpFirstScreenDelegate: AnyObject {
    func didTapNextButton(userCredentials: UserCredentials)
    func goToSignIn()
}

final class SignUpFirstViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpFirstScreenDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Private properties
    
    private var isValidEnteredEmail: Bool {
        guard let email = emailTextField.text, email.count > 5 else { return false }
        return StringValidator.isValidEmail(email)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    }
    
    @IBAction private func forwardNextTapped() {
        let userCredentials = UserCredentials(email: emailTextField.text, password: passwordTextField.text)
        delegate?.didTapNextButton(userCredentials: userCredentials)
    }
    
    @IBAction private func alreadySignedUpButtonTapped() {
        delegate?.goToSignIn()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Sign up".localize(key: "SignUpFirstViewControllerTitle")
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
