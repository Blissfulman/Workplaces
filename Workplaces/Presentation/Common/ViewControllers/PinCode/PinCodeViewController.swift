//
//  PinCodeViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 03.06.2021.
//

import UIKit

final class PinCodeViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var pinCodeTextField: UITextField!
    
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
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        pinCodeTextField.font = Fonts.title
    }
}
