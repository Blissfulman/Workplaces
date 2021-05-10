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
    
    // MARK: - Nested types
    
    enum State {
        case posts
        case likes
        case friends
    }
    
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
    private var topViewOffset: CGFloat = 0
    private var progressList = [Progress]()
    
    private lazy var profileMeView: ProfileMeView = {
        let profileMeView = ProfileMeView(delegate: self)
        profileMeView.frame = topView.bounds
        profileMeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(profileMeView)
        return profileMeView
    }()
    private lazy var postListVC: PostListViewController = {
        let postListVC = PostListViewController(posts: [], dataSource: self, delegate: self)
        postListVC.view.frame = view.bounds
        return postListVC
    }()
    private lazy var likeListVC: PostListViewController = {
        let postListVC = PostListViewController(posts: [], dataSource: self, delegate: self)
        postListVC.view.frame = view.bounds
        return postListVC
    }()
    
    private var state: State = .posts {
        didSet {
            switch state {
            case .posts:
                showPostListView()
            case .likes:
                showLikeListView()
            case .friends:
                showFriendListView()
            }
            bringProfileMeViewToFront()
        }
    }
    
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
        bringProfileMeViewToFront()
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
        
        add(likeListVC)
        likeListVC.setContentInset(contentInset: UIEdgeInsets(top: topView.frame.height, left: 0, bottom: 0, right: 0))
        
        add(postListVC)
        postListVC.setContentInset(contentInset: UIEdgeInsets(top: topView.frame.height, left: 0, bottom: 0, right: 0))
    }
    
    private func addLogOutButton() {
        // Временная кнопка для завершения сессии
        let logOutBarButtonItem = UIBarButtonItem(
            title: "Log out", style: .plain, target: self, action: #selector(logOutBarButtonTapped)
        )
        logOutBarButtonItem.tintColor = Palette.orange
        navigationItem.rightBarButtonItem = logOutBarButtonItem
    }
    
    private func bringProfileMeViewToFront() {
        view.bringSubviewToFront(topView)
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
    
    private func showPostListView() {
        // Нужно доработать правильную позицию topView при переключении
        postListVC.setTopOffset(offset: topViewOffset - topView.frame.height)
        remove(likeListVC)
        add(postListVC)
    }
    
    private func showLikeListView() {
        // Нужно доработать правильную позицию topView при переключении
        likeListVC.setTopOffset(offset: topViewOffset - topView.frame.height)
        remove(postListVC)
        add(likeListVC)
    }
    
    private func showFriendListView() {
        // Нужно доработать правильную позицию topView при переключении
        remove(postListVC)
        remove(likeListVC)
        
    }
    
    private func updateTopViewPosition() {
        topView.frame.origin.y = (topViewY ?? 0) - topViewOffset
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
        switch state {
        case .posts:
            topViewOffset = topView.frame.height + postListVC.contentOffset.y
        case .likes:
            topViewOffset = topView.frame.height + likeListVC.contentOffset.y
        case .friends:
            break
        }
        updateTopViewPosition()
    }
}

// MARK: - ProfileMeViewDelegate

extension ProfileViewController: ProfileMeViewDelegate {
    
    func segmentedControlValueChanged(to segmentedControlState: ProfileMeView.SegmentedControlState) {
        switch segmentedControlState {
        case .posts:
            state = .posts
        case .likes:
            state = .likes
        case .friends:
            state = .friends
        }
    }
}
