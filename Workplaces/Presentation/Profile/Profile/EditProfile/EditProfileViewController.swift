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
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var saveButtonBottomConstraint: NSLayoutConstraint!
    
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
            editProfileModel.editedProfile.nickname = sender.text ?? ""
        case firstNameTextField:
            editProfileModel.editedProfile.firstName = sender.text ?? ""
        case lastNameTextField:
            editProfileModel.editedProfile.lastName = sender.text ?? ""
        case birthdayTextField:
            // Временно. Позже дата будет выбираться в DatePicker
            editProfileModel.editedProfile.birthday = DateFormatter.profileDateFormatter
                .date(from: sender.text ?? "") ?? Date()
        default:
            break
        }
        updateSaveButtonState()
    }
    
    @IBAction private func saveButtonTapped() {
        delegate?.didTapSaveButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        nicknameTextField.text = editProfileModel.profile.nickname
        firstNameTextField.text = editProfileModel.profile.firstName
        lastNameTextField.text = editProfileModel.profile.lastName
        // Нужно будет вынести логику в модель
        birthdayTextField.text = DateFormatter.profileDateFormatter.string(from: editProfileModel.profile.birthday)
    }
    
    private func updateSaveButtonState() {
        saveButton.isEnabled = editProfileModel.isPossibleToSaveProfile
    }
}
