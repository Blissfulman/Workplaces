//
//  ProtectionViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 03.06.2021.
//

import UIKit

// MARK: - Protocols

protocol ProtectionViewControllerDelegate: AnyObject {
    func didTapExitButton()
    func didTapFingerprintButton()
    func didEnterPassword()
}

final class ProtectionViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var passwordTextField: UITextField!
    
    // MARK: - Private properties
    
    private let protectionModel: ProtectionModel
    private weak var delegate: ProtectionViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(protectionModel: ProtectionModel, delegate: ProtectionViewControllerDelegate) {
        self.protectionModel = protectionModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Public methods
    
    /// Отображает анимацию поля пароля, сообщающую о неверно введённом пароле.
    func indicateToWrongPassword(completion: @escaping VoidBlock) {
        passwordTextField.shakeAnimation()
        showAlert(title: "Wrong password".localized(), message: protectionModel.passwordErrorMessage) { [weak self] in
            self?.passwordTextField.text = ""
            completion()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func exitButtonTapped() {
        delegate?.didTapExitButton()
    }
    
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        guard let enteredPassword = passwordTextField.text,
              enteredPassword.count < 4 else { return }
        
        if let number = sender.titleLabel?.text {
            protectionModel.password = "\(enteredPassword)\(number)"
            passwordTextField.text = protectionModel.password
        }
        
        if protectionModel.password.count == 4 {
            delegate?.didEnterPassword()
        }
    }
    
    @IBAction private func fingerprintButtonTapped() {
        delegate?.didTapFingerprintButton()
    }
    
    @IBAction private func backspaceButtonTapped() {
        if let password = passwordTextField.text, !password.isEmpty {
            passwordTextField.text = "\(password.dropLast())"
        }
        protectionModel.password = passwordTextField.text ?? ""
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        messageLabel.text = protectionModel.screenMessage
        passwordTextField.font = Fonts.title
    }
}
