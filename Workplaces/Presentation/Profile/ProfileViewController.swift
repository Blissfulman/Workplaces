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
    private let authorizationService: AuthorizationService
    private var progressList = [Progress]()
    
    // MARK: - Initializers
    
    init(
        profileService: ProfileService = ServiceLayer.shared.profileService,
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService
    ) {
        self.profileService = profileService
        self.authorizationService = authorizationService
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
        fetchProfile()
    }
    
    // MARK: - Actions
    
    @objc private func logOutBarButtonTapped() {
        let progress = authorizationService.signOut { result in
            switch result {
            case .success:
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                    print("Window access error")
                    return
                }
                sceneDelegate.applicationCoordinator.start()
            case .failure:
                break
            }
        }
        progressList.append(progress)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Профиль"
        
        // Временная кнопка для завершения сессии
        let logOutBarButtonItem = UIBarButtonItem(
            title: "Log out", style: .plain, target: self, action: #selector(logOutBarButtonTapped)
        )
        logOutBarButtonItem.tintColor = Palette.orange
        navigationItem.rightBarButtonItem = logOutBarButtonItem
    }
    
    private func fetchProfile() {
        // Тест загрузки своего профиля
        profileService.fetchMyProfile { result in
            switch result {
            case let .success(profile):
                print("My Profile:", profile)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
        // Тест загрузки лайкнутых постов
        profileService.fetchLikedPosts { result in
            switch result {
            case let .success(likedPosts):
                print("Liked Posts:", likedPosts)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
        // Тест обновления своего профиля
        let myProfile = User(
            id: "12345",
            firstName: "Name",
            lastName: "Surname",
            nickname: "Nick",
            avatarURL: URL(string: "https://about.gitlab.com/images/press/logo/png/gitlab-icon-rgb.png"),
            birthday: Date()
        )
        let progress = profileService.updateMyProfile(user: myProfile) { [weak self] result in
            switch result {
            case let .success(profile):
                print("Updated My Profile:", profile)
            case let .failure(error):
                self?.showAlert(error)
            }
        }
        progressList.append(progress)
    }
}
