//
//  ProfileViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileScreenDelegate: AnyObject {
    func goToEditProfile(profile: User)
    func signOut()
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: ProfileScreenDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let authorizationService: AuthorizationService
    private var profile: User?
    private var myPosts = [Post]()
    private var likedPosts = [Post]()
    private var friends = [User]()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if profile == nil {
            fetchProfile()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @objc private func logOutBarButtonTapped() {
        let progress = authorizationService.signOut { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.signOut()
            case .failure:
                break
            }
        }
        progressList.append(progress)
    }
    
    @objc private func editProfileBarButtonTapped() {
        guard let profile = profile else { return }
        delegate?.goToEditProfile(profile: profile)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Профиль"
        navigationItem.backButtonTitle = ""
        navigationController?.hidesBarsOnSwipe = true
        
        addBarButtonItems()
        
        tableView.register(ProfileMeCell.nib(), forCellReuseIdentifier: ProfileMeCell.identifier)
        tableView.register(ProfileSwitchCell.nib(), forCellReuseIdentifier: ProfileSwitchCell.identifier)
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
    }
    
    private func addBarButtonItems() {
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
                self?.navigationItem.title = "@kshn13" // profile.nickname
                self?.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Table view data source

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileMeCell.identifier,
                for: indexPath
            ) as? ProfileMeCell else { return UITableViewCell() }
            
            cell.configure(user: profile)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileSwitchCell.identifier,
                for: indexPath
            ) as? ProfileSwitchCell else { return UITableViewCell() }
            
            cell.configure()
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostCell.identifier,
                for: indexPath
            ) as? PostCell else { return UITableViewCell() }
            
            cell.configure()
            return cell
        }
    }
}
