//
//  NewPostViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol NewPostViewControllerDelegate: AnyObject {
    
}

final class NewPostViewController: KeyboardNotificationsViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var postTextView: UITextView!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var deletePostImageButton: UIButton!
    @IBOutlet private var bottomStackViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private weak var delegate: NewPostViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(delegate: NewPostViewControllerDelegate) {
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
            self.bottomStackViewBottomConstraint.constant = keyboardFrame.height
                + UIConstants.defaultSpacingBetweenContentAndKeyboard
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        animateWithKeyboard(notification: notification) { _ in
            self.bottomStackViewBottomConstraint.constant = 16
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        postTextView.delegate = self
        postTextView.tintColor = Palette.orange
        postTextView.tintColorDidChange()
        postImageView.setCornerRadius(UIConstants.newPostImageCornerRadius)
    }
}

// MARK: - Text view delegate

extension NewPostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Palette.middleGrey && textView.isFirstResponder {
            textView.text = nil
            textView.textColor = Palette.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = Palette.middleGrey
            textView.text = "What do you want to share?".localized()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 80
    }
}
