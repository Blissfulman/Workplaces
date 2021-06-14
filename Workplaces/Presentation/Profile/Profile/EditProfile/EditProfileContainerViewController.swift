//
//  EditProfileContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 14.05.2021.
//

import UIKit

// MARK: - Protocols

protocol EditProfileContainerViewControllerDelegate: AnyObject {
    func profileDidSave()
}

final class EditProfileContainerViewController: BaseViewController {
    
    // MARK: - Public properties
    
    weak var delegate: EditProfileContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let editProfileModel: EditProfileModel
    private var progressList = [Progress]()
    private let imagePickerController = UIImagePickerController()
    private lazy var editProfileVC = EditProfileViewController(editProfileModel: editProfileModel, delegate: self)
    
    // MARK: - Initializers
    
    init(profile: User, profileService: ProfileService = ServiceLayer.shared.profileService) {
        self.editProfileModel = EditProfileModel(profile: profile)
        self.profileService = profileService
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
        imagePickerController.delegate = self
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func changeAvatarBarButtonTapped() {
        view.endEditing(true)
        present(imagePickerController, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBarController?.tabBar.isHidden = true
        addChangeAvatarButton()
        imagePickerController.sourceType = .savedPhotosAlbum
        addFullover(editProfileVC)
    }
    
    private func addChangeAvatarButton() {
        navigationItem.rightBarButtonItem = MainBarButtonItem(
            title: "Change avatar".localized(),
            style: .plain,
            target: self,
            action: #selector(changeAvatarBarButtonTapped)
        )
    }
}

// MARK: - EditProfileViewControllerDelegate

extension EditProfileContainerViewController: EditProfileViewControllerDelegate {
    
    func didTapSaveButton() {
        LoadingView.show()
        
        let progress = profileService.updateMyProfile(uploadUser: editProfileModel.uploadUser) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case .success:
                self?.delegate?.profileDidSave()
            case let .failure(error):
                self?.showAlert(error: error)
            }
        }
        progressList.append(progress)
    }
}

// MARK: - Image picker controller delegate

extension EditProfileContainerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        defer { imagePickerController.dismiss(animated: true) }
        editProfileModel.avatarURL = info[.imageURL] as? URL
    }
}
