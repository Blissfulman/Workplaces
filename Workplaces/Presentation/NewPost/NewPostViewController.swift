//
//  NewPostViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol NewPostViewControllerDelegate: AnyObject {
    func didTapAddLocationButton()
    func didTapPublishPostButton()
}

final class NewPostViewController: KeyboardNotificationsViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var postTextView: UITextView!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var deletePostImageButton: UIButton!
    @IBOutlet private var publishPostButton: UIButton!
    @IBOutlet private var betweenImageViewAndBottomButtonsConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomStackViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private let newPostModel: NewPostModel
    private weak var delegate: NewPostViewControllerDelegate?
    private let imagePickerController = UIImagePickerController()
    
    // MARK: - Initializers
    
    init(newPostModel: NewPostModel, delegate: NewPostViewControllerDelegate) {
        self.newPostModel = newPostModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTextView.delegate = self
        imagePickerController.delegate = self
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
    
    // MARK: - Actions
    
    @IBAction private func deletePostImageButtonTapped() {
        postImageView.disappear { [weak self] in
            self?.postImageView.image = nil
            self?.betweenImageViewAndBottomButtonsConstraint.isActive = false
        }
        deletePostImageButton.disappear()
        newPostModel.imageFileURL = nil
    }
    
    @IBAction private func addLocationButtonTapped() {
        delegate?.didTapAddLocationButton()
    }
    
    @IBAction private func addImageButtonTapped() {
        view.endEditing(true)
        present(imagePickerController, animated: true)
    }
    
    @IBAction private func publishPostButtonTapped() {
        view.endEditing(true)
        delegate?.didTapPublishPostButton()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        postTextView.tintColor = Palette.orange
        postTextView.tintColorDidChange()
        postTextView.text = "What do you want to share?".localized()
        postImageView.setCornerRadius(UIConstants.newPostImageCornerRadius)
        imagePickerController.sourceType = .savedPhotosAlbum
        betweenImageViewAndBottomButtonsConstraint.isActive = false
    }
    
    private func updatePublishPostButtonState() {
        publishPostButton.isEnabled = newPostModel.isPossibleToPublishPost
    }
    
    private func showImage() {
        postImageView.appear()
        deletePostImageButton.appear()
        betweenImageViewAndBottomButtonsConstraint.isActive = true
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
        return newText.count <= UIConstants.postTextMaxLength
    }
    
    func textViewDidChange(_ textView: UITextView) {
        newPostModel.text = postTextView.text
        updatePublishPostButtonState()
    }
}

// MARK: - Image picker controller delegate

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        defer { imagePickerController.dismiss(animated: true) }
        
        newPostModel.imageFileURL = info[.imageURL] as? URL
        postImageView.image = info[.originalImage] as? UIImage
        showImage()
    }
}
