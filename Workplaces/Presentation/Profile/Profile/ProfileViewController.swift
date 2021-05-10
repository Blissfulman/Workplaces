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
    
    @IBOutlet private weak var topView: UIView!
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let authorizationService: AuthorizationService
    private var profile: User? {
        didSet {
            navigationItem.title = "@kshn13" // profile.nickname
            configureProfileMeView()
        }
    }
    private var topViewY: CGFloat?
    private var progressList = [Progress]()
    
    private lazy var profileMeView = ProfileMeView(delegate: self)
    private lazy var postListVC: PostListViewController = {
        let postListVC = PostListViewController(posts: [], dataSource: self, delegate: self)
        postListVC.view.frame = view.bounds
        return postListVC
    }()
    
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
        // Свойство должно быть высчитано один раз при первом появлении вью на экране
        topViewY = topViewY ?? topView.frame.origin.y
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
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Profile".localized()
        navigationItem.backButtonTitle = ""
//        navigationController?.hidesBarsOnSwipe = true
        
        addLogOutButton()
        
        add(postListVC)
        postListVC.setContentInset(contentInset: UIEdgeInsets(top: topView.frame.height, left: 0, bottom: 0, right: 0))
        addProfileMeView()
    }
    
    private func addLogOutButton() {
        // Временная кнопка для завершения сессии
        let logOutBarButtonItem = UIBarButtonItem(
            title: "Log out", style: .plain, target: self, action: #selector(logOutBarButtonTapped)
        )
        logOutBarButtonItem.tintColor = Palette.orange
        navigationItem.rightBarButtonItem = logOutBarButtonItem
    }
    
    private func addProfileMeView() {
        view.bringSubviewToFront(topView)
        profileMeView.frame = topView.bounds
        profileMeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(profileMeView)
    }
    
    private func configureProfileMeView() {
        guard let profile = profile else { return }
        
        let editProfileButtonAction: VoidBlock = { [weak self] in
            self?.delegate?.goToEditProfile(profile: profile)
        }
        profileMeView.configure(profile: profile, editProfileButtonAction: editProfileButtonAction)
    }
    
    private func fetchProfile() {
        LoadingView.show()
        
        profileService.fetchMyProfile { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(profile):
                self?.profile = profile
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostCell.identifier,
            for: indexPath
        ) as? PostCell else { return UITableViewCell() }
        
        cell.configure()
        return cell
    }
}

// MARK: - Table view delegate

extension ProfileViewController: UITableViewDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topViewY = (topViewY ?? 0) - topView.frame.height - postListVC.contentOffset.y
        topView.frame.origin.y = topViewY
    }
}

// MARK: - ProfileMeViewDelegate

extension ProfileViewController: ProfileMeViewDelegate {
    
    func segmentedControlValueChanged(to segmentedControlState: ProfileMeView.SegmentedControlState) {
        print(segmentedControlState)
    }
}
