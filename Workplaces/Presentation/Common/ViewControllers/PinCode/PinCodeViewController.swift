//
//  PinCodeViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 03.06.2021.
//

import UIKit

// MARK: - Protocols

protocol PinCodeViewControllerDelegate: AnyObject {
    func successfulPinCodeSetup()
    func logOut()
}

final class PinCodeViewController: BaseViewController {
    
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
    
    // MARK: - Actions
    
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        if let buttonNumber = sender.titleLabel?.text {
            pinCodeTextField.text = "\(pinCodeTextField.text ?? "")\(buttonNumber)"
        }
        pinCodeModel.password = pinCodeTextField.text ?? ""
    }
    
    @IBAction private func fingerprintButtonTapped() {
        delegate?.successfulPinCodeSetup() // TEMP
    }
    
    @IBAction private func backspaceButtonTapped() {
        if let pinCode = pinCodeTextField.text, !pinCode.isEmpty {
            pinCodeTextField.text = "\(pinCode.dropLast())"
        }
    }
    
    @IBAction private func exitButtonTapped() {
        delegate?.logOut()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        messageLabel.text = pinCodeModel.message
        pinCodeTextField.font = Fonts.title
    }
}
