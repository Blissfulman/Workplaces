//
//  SignUpFirstViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit
import WorkplacesAPI

// MARK: - Protocols

protocol SignUpFirstScreenCoordinable {
    var didTapNextButton: ((UserCredentials) -> Void)? { get set }
    var didTapAlreadyRegisteredButton: VoidBlock? { get set }
}

final class SignUpFirstViewController: UIViewController, SignUpFirstScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapNextButton: ((UserCredentials) -> Void)?
    var didTapAlreadyRegisteredButton: VoidBlock?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
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
    
    @IBAction private func nextButtonTapped() {
        let userCredentials = UserCredentials(email: emailTextField.text, password: passwordTextField.text)
        didTapNextButton?(userCredentials)
    }
    
    @IBAction private func alreadyRegisteredButtonTapped() {
        didTapAlreadyRegisteredButton?()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Регистрация"
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
