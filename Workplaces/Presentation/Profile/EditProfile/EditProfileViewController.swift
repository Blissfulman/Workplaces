//
//  EditProfileViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol EditProfileScreenCoordinable {
    var didTapSaveButton: VoidBlock? { get set }
}

final class EditProfileViewController: UIViewController, EditProfileScreenCoordinable {
    
    // MARK: - Nested types
    
    struct EditingUser {
        var nickname: String
        var firstName: String
        var lastName: String
        var birthday: Date
        
        init(user: User) {
            self.nickname = user.nickname ?? ""
            self.firstName = user.firstName
            self.lastName = user.lastName
            self.birthday = user.birthday
        }
    }
    
    // MARK: - Public properties
    
    var didTapSaveButton: VoidBlock?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: - Private properties
    
    private let profile: User
    private let profileService: ProfileService
    private var progressList = [Progress]()
    
    private var editedProfile: EditingUser {
        didSet {
            updateSaveButtonState()
        }
    }
    private var hasNotBeenEditedProfile: Bool {
        profile.nickname ?? "" == editedProfile.nickname
            && profile.firstName == editedProfile.firstName
            && profile.lastName == editedProfile.lastName
            && profile.birthday == editedProfile.birthday
    }
    private var isEmptyAtLeastOneTextField: Bool {
        // Поле birthday не должно получаться пустым, т.к. будет заполняться на основе DatePicker
        editedProfile.nickname.isEmpty || editedProfile.firstName.isEmpty || editedProfile.lastName.isEmpty
    }
    
    // MARK: - Initializers
    
    init(profile: User, profileService: ProfileService = ServiceLayer.shared.profileService) {
        self.profile = profile
        self.profileService = profileService
        self.editedProfile = EditingUser(user: profile)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        progressList.forEach { $0.cancel() }
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
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        switch sender {
        case nicknameTextField:
            editedProfile.nickname = sender.text ?? ""
        case firstNameTextField:
            editedProfile.firstName = sender.text ?? ""
        case lastNameTextField:
            editedProfile.lastName = sender.text ?? ""
        case birthdayTextField:
            // Временно. Позже дата будет выпираться из DatePicker
            editedProfile.birthday = DateFormatter.profileDateFormatter.date(from: sender.text ?? "") ?? Date()
        default:
            break
        }
        updateSaveButtonState()
    }
    
    @IBAction private func saveButtonTapped() {
        let updatedProfile = User(
            id: profile.id,
            firstName: editedProfile.firstName,
            lastName: editedProfile.lastName,
            nickname: editedProfile.nickname,
            avatarURL: profile.avatarURL,
            birthday: editedProfile.birthday
        )
        
        LoadingView.show()
        let progress = profileService.updateMyProfile(user: updatedProfile) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(profile):
                print("Updated My Profile:", profile)
                self?.didTapSaveButton?()
            case let .failure(error):
                self?.showAlert(error)
            }
        }
        progressList.append(progress)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBarController?.tabBar.isHidden = true
        nicknameTextField.text = profile.nickname
        firstNameTextField.text = profile.firstName
        lastNameTextField.text = profile.lastName
        birthdayTextField.text = DateFormatter.profileDateFormatter.string(from: profile.birthday)
    }
    
    private func updateSaveButtonState() {
        saveButton.isEnabled = !hasNotBeenEditedProfile && !isEmptyAtLeastOneTextField
    }
}
