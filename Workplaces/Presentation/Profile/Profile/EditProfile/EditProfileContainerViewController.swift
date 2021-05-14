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

final class EditProfileContainerViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: EditProfileContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let editProfileModel: EditProfileModel
    private var progressList = [Progress]()
    private lazy var editProfileVC: EditProfileViewController = {
        let editProfileVC = EditProfileViewController(editProfileModel: editProfileModel, delegate: self)
        editProfileVC.view.frame = view.bounds
        return editProfileVC
    }()
    
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
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBarController?.tabBar.isHidden = true
        add(editProfileVC)
    }
}

// MARK: - EditProfileViewControllerDelegate

extension EditProfileContainerViewController: EditProfileViewControllerDelegate {
    
    func didTapSaveButton() {
        LoadingView.show()
        
        let progress = profileService.updateMyProfile(user: editProfileModel.updatedProfile) { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(profile):
                print("Updated my profile:", profile) // TEMP
                self?.delegate?.profileDidSave()
            case let .failure(error):
                self?.showAlert(error)
            }
        }
        progressList.append(progress)
    }
}
