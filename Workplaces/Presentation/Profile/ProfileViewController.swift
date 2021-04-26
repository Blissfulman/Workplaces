//
//  ProfileViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    
    // MARK: - Initializers
    
    init(profileService: ProfileService = ProfileServiceImpl(apiClient: ServiceLayer.shared.apiClient)) {
        self.profileService = profileService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProfile()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Профиль"
    }
    
    private func fetchProfile() {
        profileService.fetchLikedPosts { result in
            switch result {
            case let .success(likedPosts):
                print(likedPosts)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
