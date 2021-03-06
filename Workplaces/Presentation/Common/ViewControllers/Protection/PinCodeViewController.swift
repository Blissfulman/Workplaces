//
//  ProtectionViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 03.06.2021.
//

import UIKit

// MARK: - Protocols

protocol PinCodeViewControllerDelegate: AnyObject {
    func logOut()
    func didTapFingerprintButton()
    func didEnterPassword()
}

final class ProtectionViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var pinCodeTextField: UITextField!
    
    // MARK: - Private properties
    
    private let pinCodeModel: PinCodeModel
    private weak var delegate: PinCodeViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(pinCodeModel: PinCodeModel, delegate: PinCodeViewControllerDelegate) {
        self.pinCodeModel = pinCodeModel
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
        pinCodeTextField.shakeAnimation()
        showAlert(title: "Wrong password".localized(), message: pinCodeModel.passwordErrorMessage) { [weak self] in
            self?.pinCodeTextField.text = ""
            completion()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func exitButtonTapped() {
        delegate?.logOut()
    }
    
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        guard let enteredPassword = pinCodeTextField.text,
              enteredPassword.count < 4 else { return }
        
        if let number = sender.titleLabel?.text {
            pinCodeModel.password = "\(enteredPassword)\(number)"
            pinCodeTextField.text = pinCodeModel.password
        }
        
        if pinCodeModel.password.count == 4 {
            delegate?.didEnterPassword()
        }
    }
    
    @IBAction private func fingerprintButtonTapped() {
        delegate?.didTapFingerprintButton()
    }
    
    @IBAction private func backspaceButtonTapped() {
        if let pinCode = pinCodeTextField.text, !pinCode.isEmpty {
            pinCodeTextField.text = "\(pinCode.dropLast())"
        }
        pinCodeModel.password = pinCodeTextField.text ?? ""
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        messageLabel.text = pinCodeModel.screenMessage
        pinCodeTextField.font = Fonts.title
    }
}
