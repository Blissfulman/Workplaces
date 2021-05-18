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
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var signUpButtonBottomConstraint: NSLayoutConstraint!
    
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
    
    // MARK: - Deinitializer
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerForKeyboardNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        datePicker.disappear()
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldsEditingChanged(_ sender: UITextField) {
        switch sender {
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
    
    @IBAction private func signUpButtonTapped() {
        delegate?.didTapSignUpButton()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = value.cgRectValue.height
        
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signUpButtonBottomConstraint.constant = keyboardHeight
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: UIConstants.keyboardAppearAnimationDuration) {
            self.signUpButtonBottomConstraint.constant = UIConstants.defaultLowerButtonsBottomSpacing
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Sign up".localized()
        navigationController?.setNavigationBarHidden(false, animated: true)
        firstNameTextField.text = signUpModel.firstName
        lastNameTextField.text = signUpModel.lastName
        if let birthday = signUpModel.birthday {
            birthdayTextField.text = DateFormatter.profileDateFormatter.string(from: birthday)
            datePicker.date = birthday
        }
        datePicker.subviews.first?.subviews.last?.backgroundColor = .clear
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
