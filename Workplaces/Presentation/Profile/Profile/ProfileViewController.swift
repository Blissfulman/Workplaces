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
    @IBOutlet private weak var zeroView: UIView!
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let authorizationService: AuthorizationService
    private var profile: User? {
        didSet {
            navigationItem.title = profile?.nickname
            configureProfileMeView()
        }
    }
    private let postListDataSource = TableViewDataSource<Post, PostCell>()
    private let likeListDataSource = TableViewDataSource<Post, PostCell>()
    private let friendListDataSource = TableViewDataSource<User, FriendCell>()
    
    private var topViewY: CGFloat?
    private var topViewOffset: CGFloat = 0
    /// Толщина разделителя между верхним вью и списком друзей.
    private let friendListSeparator: CGFloat = 9
    private var progressList = [Progress]()
    
    private lazy var profileTopView: ProfileTopView = {
        let profileTopView = ProfileTopView(delegate: self)
        profileTopView.frame = topView.bounds
        profileTopView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topView.addSubview(profileTopView)
        return profileTopView
    }()
    private lazy var postListVC: PostListViewController = {
        let postListVC = PostListViewController(dataSource: postListDataSource, delegate: self)
        postListDataSource.delegate = postListVC
        postListVC.view.frame = view.bounds
        return postListVC
    }()
    private lazy var likeListVC: PostListViewController = {
        let likeListVC = PostListViewController(dataSource: likeListDataSource, delegate: self)
        likeListDataSource.delegate = likeListVC
        likeListVC.view.frame = view.bounds
        return likeListVC
    }()
    private lazy var friendListVC: FriendListViewController = {
        let friendListVC = FriendListViewController(dataSource: friendListDataSource, delegate: self)
        friendListDataSource.delegate = friendListVC
        friendListVC.view.frame = view.bounds
        return friendListVC
    }()
    private lazy var errorVC: ZeroViewController = {
        let zeroVC = ZeroViewController(viewType: .noData, buttonAction: {})
        zeroVC.view.frame = view.bounds
        return zeroVC
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
        fetchMyPosts()
        fetchLikedPosts()
        fetchFriends()
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
        
        add(friendListVC)
        friendListVC.setContentInset(
            contentInset: UIEdgeInsets(top: topView.frame.height + friendListSeparator, left: 0, bottom: 0, right: 0)
        )
        
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
        profileTopView.configure(profile: profile, editProfileButtonAction: editProfileButtonAction)
    }
    
    private func showPostListView() {
        // Нужно доработать правильную позицию topView при переключении
        postListVC.setTopOffset(offset: topViewOffset - topView.frame.height)
        remove(likeListVC)
        remove(friendListVC)
        add(postListVC)
    }
    
    private func showLikeListView() {
        // Нужно доработать правильную позицию topView при переключении
        likeListVC.setTopOffset(offset: topViewOffset - topView.frame.height)
        remove(postListVC)
        remove(friendListVC)
        add(likeListVC)
    }
    
    private func showFriendListView() {
        // Нужно доработать правильную позицию topView при переключении
        remove(postListVC)
        remove(likeListVC)
        add(friendListVC)
    }
    
    private func updateTopViewPosition() {
        topView.frame.origin.y = (topViewY ?? 0) - topViewOffset
    }
}

// MARK: - ProfileMeViewDelegate

extension ProfileViewController: ProfileMeViewDelegate {
    
    func segmentedControlValueChanged(to segmentedControlState: ProfileTopView.SegmentedControlState) {
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

// MARK: - PostListViewControllerDelegate, FriendListViewControllerDelegate

extension ProfileViewController: PostListViewControllerDelegate, FriendListViewControllerDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch state {
        case .posts:
            topViewOffset = topView.frame.height + postListVC.contentOffset.y
        case .likes:
            topViewOffset = topView.frame.height + likeListVC.contentOffset.y
        case .friends:
            topViewOffset = friendListSeparator + topView.frame.height + friendListVC.contentOffset.y
        }
        updateTopViewPosition()
    }
}

// MARK: - Data fetching methods

extension ProfileViewController {
    
    private func fetchProfile() {
        LoadingView.show()
        
        profileService.fetchMyProfile { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(profile):
//                self?.profile = profile
                self?.profile = User.getMockUsers().first!
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchMyPosts() {
        LoadingView.show()

        profileService.fetchMyPosts { [weak self] result in
            LoadingView.hide()
            switch result {
            case let .success(myPosts):
//                self?.postListDataSource.updateData(objects: myPosts)
                self?.postListDataSource.updateData(objects: Post.getMockPosts())
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchLikedPosts() {
        LoadingView.show()

        profileService.fetchLikedPosts { [weak self] result in
            LoadingView.hide()
            switch result {
            case let .success(likedPosts):
//                self?.likeListDataSource.updateData(objects: likedPosts)
                self?.likeListDataSource.updateData(objects: Post.getMockPosts())
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchFriends() {
        LoadingView.show()

        profileService.fetchFriends { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(friends):
//                self?.friendListDataSource.updateData(objects: friends)
                self?.friendListDataSource.updateData(objects: User.getMockUsers())
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
