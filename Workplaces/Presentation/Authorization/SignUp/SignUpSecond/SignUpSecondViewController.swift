//
//  SignUpSecondViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignUpSecondViewControllerDelegate: AnyObject {
    func didTapSaveButton()
}

final class SignUpSecondViewController: KeyboardNotificationsViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SignUpSecondViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private var nicknameTextField: UITextField!
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var birthdayTextField: UITextField!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var saveButtonBottomConstraint: NSLayoutConstraint!
    
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
        datePicker.disappear()
    }
    
    // MARK: - KeyboardNotificationsViewController
    
    override func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification: notification)
        
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.saveButtonBottomConstraint.constant = keyboardHeight
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide() {
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.saveButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        switch sender {
        case nicknameTextField:
            signUpModel.nickname = nicknameTextField.text
        case firstNameTextField:
            signUpModel.firstName = firstNameTextField.text
        case lastNameTextField:
            signUpModel.lastName = lastNameTextField.text
        default:
            break
        }
    }
    
    @IBAction private func textFieldsEditingDidBegin() {
        datePicker.disappear()
    }
    
    @IBAction private func pickDateButtonTapped() {
        view.endEditing(true)
        datePicker.appear()
    }
    
    @IBAction private func datePickerValueChanged() {
        birthdayTextField.text = DateFormatter.profileDateFormatter.string(from: datePicker.date)
        signUpModel.birthday = datePicker.date
    }
    
    @IBAction private func saveButtonTapped() {
        delegate?.didTapSaveButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Sign up".localized()
        navigationItem.setHidesBackButton(true, animated: true)
    }
}

// MARK: - Text field delegate

extension SignUpSecondViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nicknameTextField:
            firstNameTextField.becomeFirstResponder()
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            pickDateButtonTapped()
        default:
            break
        }
        return true
    }
}
