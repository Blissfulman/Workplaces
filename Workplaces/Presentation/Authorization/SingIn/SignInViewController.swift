//
//  SignInViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

protocol SignInScreenCoordinable {
    var didTapRegisterButton: (() -> Void)? { get set }
    var didTapEnterButton: (() -> Void)? { get set }
}

final class SignInViewController: UIViewController, SignInScreenCoordinable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var enterButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Public properties
    
    var didTapRegisterButton: (() -> Void)?
    var didTapEnterButton: (() -> Void)?
    
    // MARK: - Deinitialization
    
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
    }
    
    // MARK: - Actions
    
    @IBAction private func registerButtonTapped() {
        didTapRegisterButton?()
    }
    
    @IBAction private func enterButtonTapped() {
        didTapEnterButton?()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        enterButtonBottomConstraint.constant = 16 + keyboardFrame.height
    }
    
    @objc private func keyboardWillHide() {
        enterButtonBottomConstraint.constant = 16
    }
    
//    @objc private func closeButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Вход по почте"
        navigationController?.setNavigationBarHidden(false, animated: true)
//        let backBarButtonItem = UIBarButtonItem(image: Icons.crossSmall,
//                                                style: .plain,
//                                                target: self,
//                                                action: #selector(closeButtonTapped))
//        navigationItem.leftBarButtonItem = backBarButtonItem
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
