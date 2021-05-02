//
//  ProfileViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileScreenCoordinable {
    var didTapEditProfileButton: ((User) -> Void)? { get set }
    var didTapLogOutButton: VoidBlock? { get set }
}

final class ProfileViewController: UIViewController, ProfileScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapEditProfileButton: ((User) -> Void)?
    var didTapLogOutButton: VoidBlock?
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let authorizationService: AuthorizationService
    private var profile: User?
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
        let progress = authorizationService.signOut { [weak self] result in
            switch result {
            case .success:
                self?.didTapLogOutButton?()
            case .failure:
                break
            }
        }
        progressList.append(progress)
    }
    
    @objc private func editProfileBarButtonTapped() {
        guard let profile = profile else { return }
        
        didTapEditProfileButton?(profile)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Профиль"
        navigationItem.backButtonTitle = ""
        
        // Временная кнопка для перехода к редактированию профиля
        let editProfileBarButtonItem = UIBarButtonItem(
            title: "Edit profile", style: .plain, target: self, action: #selector(editProfileBarButtonTapped)
        )
        editProfileBarButtonItem.tintColor = Palette.darkGrey
        navigationItem.leftBarButtonItem = editProfileBarButtonItem
        
        // Временная кнопка для завершения сессии
        let logOutBarButtonItem = UIBarButtonItem(
            title: "Log out", style: .plain, target: self, action: #selector(logOutBarButtonTapped)
        )
        logOutBarButtonItem.tintColor = Palette.orange
        navigationItem.rightBarButtonItem = logOutBarButtonItem
    }
    
    private func fetchProfile() {
        LoadingView.show()
        
        profileService.fetchMyProfile { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(profile):
                self?.profile = profile
                self?.navigationItem.title = profile.nickname
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func testFetchLikes() {
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
