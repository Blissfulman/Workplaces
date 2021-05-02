//
//  EditProfileViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import UIKit

// MARK: - Protocols

protocol EditProfileScreenCoordinable {
    var didTapSaveButton: ((User) -> Void)? { get set }
}

final class EditProfileViewController: UIViewController, EditProfileScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapSaveButton: ((User) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nicknameTextField: UITextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: - Private properties
    
    private var profile: User
    
    // MARK: - Initializers
    
    init(profile: User) {
        self.profile = profile
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
    
    @IBAction private func saveButtonTapped() {
        didTapSaveButton?(profile)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        nicknameTextField.text = profile.nickname
        firstNameTextField.text = profile.firstName
        lastNameTextField.text = profile.lastName
        birthdayTextField.text = String(describing: profile.birthday) // TEMP
    }
}
