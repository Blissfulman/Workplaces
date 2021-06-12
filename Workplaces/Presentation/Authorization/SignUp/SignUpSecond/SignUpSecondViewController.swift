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
    
    // MARK: - Outlets
    
    @IBOutlet private var nicknameTextField: UITextField!
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var birthdayTextField: UITextField!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var saveButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let signUpModel: SignUpModel
    private weak var delegate: SignUpSecondViewControllerDelegate?
    
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
    
    // MARK: - KeyboardNotificationsViewController
    
    override func keyboardWillShow(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { keyboardFrame in
            self.saveButtonBottomConstraint.constant = keyboardFrame.height
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { _ in
            self.saveButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
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
    
    @IBAction private func textFieldsEditingDidBegin(_ sender: UITextField) {
        if sender != birthdayTextField {
            datePicker.disappear()
        } else {
            view.endEditing(true)
            showDatePicker()
        }
    }
    
    @IBAction private func datePickerValueChanged() {
        birthdayTextField.text = DateFormatter.profileDateFormatter.string(from: datePicker.date)
        signUpModel.birthday = datePicker.date
    }
    
    @IBAction private func saveButtonTapped() {
        view.endEditing(true)
        delegate?.didTapSaveButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Sign up".localized()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func showDatePicker() {
        guard datePicker.isHidden else { return }
        datePicker.appear()
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
            textField.resignFirstResponder()
            showDatePicker()
        default:
            break
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == birthdayTextField {
            view.endEditing(true)
            showDatePicker()
            return false
        }
        return true
    }
}
