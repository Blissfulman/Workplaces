//
//  SignUpFirstViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpFirstScreenCoordinable {
    var didTapNextButton: ((User, String?) -> Void)? { get set }
    var didTapAlreadyRegisteredButton: VoidBlock? { get set }
}

final class SignUpFirstViewController: UIViewController, SignUpFirstScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapNextButton: ((User, String?) -> Void)?
    var didTapAlreadyRegisteredButton: VoidBlock?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Private properties
    
    private var user = User()
    
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
        user.login = loginTextField.text
        user.email = emailTextField.text
        didTapNextButton?(user, passwordTextField.text)
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
