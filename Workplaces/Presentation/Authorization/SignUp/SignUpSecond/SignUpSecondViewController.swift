//
//  SignUpSecondViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpSecondViewControllerDelegate: AnyObject {
    func didTapSignUpButton()
}

final class SignUpSecondViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpSecondViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var bithdayTextField: UITextField!
    
    // MARK: - Private properties
    
    private let signUpModel: SignUpModel
    
    // MARK: - Initializers
    
    init(signUpModel: SignUpModel, delegate: SignUpSecondViewControllerDelegate) {
        self.signUpModel = signUpModel
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpButtonTapped() {
        signUpModel.firstName = firstNameTextField.text
        signUpModel.lastName = lastNameTextField.text
        // !!! Добавить реализацию с датой
        signUpModel.birthday = Date()
        delegate?.didTapSignUpButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Sign up".localized()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
