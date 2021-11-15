//
//  EditProfileViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol EditProfileViewControllerDelegate: AnyObject {
    func didTapSaveButton()
}

final class EditProfileViewController: KeyboardNotificationsViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var nicknameTextField: UITextField!
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var birthdayTextField: UITextField!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var saveButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let editProfileModel: EditProfileModel
    private weak var delegate: EditProfileViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(editProfileModel: EditProfileModel, delegate: EditProfileViewControllerDelegate) {
        self.editProfileModel = editProfileModel
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
        let safeAreaBottomInset = view.safeAreaInsets.bottom
        animateWithKeyboard(notification: notification) { keyboardFrame in
            self.saveButtonBottomConstraint.constant = keyboardFrame.height
                + UIConstants.defaultSpacingBetweenContentAndKeyboard - safeAreaBottomInset
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { _ in
            self.saveButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
        }
    }
    
    // MARK: - Public methods
    
    func updateSaveButtonState() {
        saveButton.isEnabled = editProfileModel.isPossibleToSaveProfile
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        switch sender {
        case nicknameTextField:
            editProfileModel.editedProfile.nickname = sender.text ?? ""
        case firstNameTextField:
            editProfileModel.editedProfile.firstName = sender.text ?? ""
        case lastNameTextField:
            editProfileModel.editedProfile.lastName = sender.text ?? ""
        default:
            break
        }
        updateSaveButtonState()
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
        editProfileModel.editedProfile.birthday = datePicker.date
        birthdayTextField.text = editProfileModel.stringBirthday
        updateSaveButtonState()
    }
    
    @IBAction private func saveButtonTapped() {
        view.endEditing(true)
        delegate?.didTapSaveButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        nicknameTextField.text = editProfileModel.profile.nickname
        firstNameTextField.text = editProfileModel.profile.firstName
        lastNameTextField.text = editProfileModel.profile.lastName
        birthdayTextField.text = editProfileModel.stringBirthday
        datePicker.date = editProfileModel.profile.birthday
    }
    
    private func showDatePicker() {
        guard datePicker.isHidden else { return }
        datePicker.appear()
    }
}

// MARK: - Text field delegate

extension EditProfileViewController: UITextFieldDelegate {
    
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
