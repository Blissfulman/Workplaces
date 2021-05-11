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
    func goToNewPost()
    func goToFeed()
    func goToSearchFriends()
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
            configureProfileTopView()
        }
    }
    private let postListDataSource = TableViewDataSource<Post, PostCell>()
    private let likeListDataSource = TableViewDataSource<Post, PostCell>()
    private let friendListDataSource = TableViewDataSource<User, FriendCell>()
    
    /// Изначальное положение topView по вертикали.
    private var topViewInitialY: CGFloat?
    /// Текущее смещение topView по вертикали.
    private var topViewOffsetY: CGFloat = 0
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
    
    private var state: State = .posts {
        didSet {
            updateScreen()
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
        // Свойство должно быть высчитано один раз при первом появлении вью на экране
        topViewInitialY = topViewInitialY ?? topView.frame.origin.y
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
        addLogOutButton() // TEMP
        addChildViewControllers()
        bringProfileTopViewToFront()
    }
    
    private func addLogOutButton() {
        // Временная кнопка для завершения сессии
        let logOutBarButtonItem = UIBarButtonItem(
            title: "Log out", style: .plain, target: self, action: #selector(logOutBarButtonTapped)
        )
        logOutBarButtonItem.tintColor = Palette.orange
        navigationItem.rightBarButtonItem = logOutBarButtonItem
    }
    
    private func addChildViewControllers() {
        add(friendListVC)
        friendListVC.setContentInset(
            contentInset: UIEdgeInsets(top: topView.frame.height + friendListSeparator, left: 0, bottom: 0, right: 0)
        )
        add(likeListVC)
        likeListVC.setContentInset(contentInset: UIEdgeInsets(top: topView.frame.height, left: 0, bottom: 0, right: 0))
        add(postListVC)
        postListVC.setContentInset(contentInset: UIEdgeInsets(top: topView.frame.height, left: 0, bottom: 0, right: 0))
    }
    
    private func updateScreen() {
        switch state {
        case .posts:
            showPostList()
        case .likes:
            showLikeList()
        case .friends:
            showFriendList()
        }
        bringProfileTopViewToFront()
    }
    
    private func bringProfileTopViewToFront() {
        view.bringSubviewToFront(topView)
    }
    
    private func configureProfileTopView() {
        guard let profile = profile else { return }
        
        let editProfileButtonAction: VoidBlock = { [weak self] in
            self?.delegate?.goToEditProfile(profile: profile)
        }
        profileTopView.configure(profile: profile, editProfileButtonAction: editProfileButtonAction)
    }
    
    private func showPostList() {
        if postListDataSource.isEmptyData {
            showZeroView(state: state)
        } else {
            // Нужно доработать правильную позицию topView при переключении state
            postListVC.setTopOffset(offset: topViewOffsetY - topView.frame.height)
            remove(likeListVC)
            remove(friendListVC)
            add(postListVC)
        }
    }
    
    private func showLikeList() {
        if likeListDataSource.isEmptyData {
            showZeroView(state: state)
        } else {
            // Нужно доработать правильную позицию topView при переключении state
            likeListVC.setTopOffset(offset: topViewOffsetY - topView.frame.height)
            remove(postListVC)
            remove(friendListVC)
            add(likeListVC)
        }
    }
    
    private func showFriendList() {
        if friendListDataSource.isEmptyData {
            showZeroView(state: state)
        } else {
            // Нужно доработать правильную позицию topView при переключении state
            remove(postListVC)
            remove(likeListVC)
            add(friendListVC)
        }
    }
    
    private func showZeroView(state: State) {
        var zeroSubview: ZeroView?
        
        switch state {
        case .posts:
            let buttonAction: VoidBlock = { [weak self] in
                self?.delegate?.goToNewPost()
            }
            zeroSubview = ZeroView(viewType: .profileNoPosts, buttonAction: buttonAction)
        case .likes:
            let buttonAction: VoidBlock = { [weak self] in
                self?.delegate?.goToFeed()
            }
            zeroSubview = ZeroView(viewType: .profileNoLikes, buttonAction: buttonAction)
        case .friends:
            let buttonAction: VoidBlock = { [weak self] in
                self?.delegate?.goToSearchFriends()
            }
            zeroSubview = ZeroView(viewType: .profileNoFriends, buttonAction: buttonAction)
        }
        
        if let zeroSubview = zeroSubview {
            zeroView.subviews.forEach { $0.removeFromSuperview() }
            zeroSubview.frame = zeroView.bounds
            zeroSubview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            zeroView.addSubview(zeroSubview)
            view.bringSubviewToFront(zeroView)
        }
    }
    
    private func updateTopViewPosition() {
        topView.frame.origin.y = (topViewInitialY ?? 0) - topViewOffsetY
    }
}

// MARK: - ProfileTopViewDelegate

extension ProfileViewController: ProfileTopViewDelegate {
    
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
            topViewOffsetY = topView.frame.height + postListVC.contentOffset.y
        case .likes:
            topViewOffsetY = topView.frame.height + likeListVC.contentOffset.y
        case .friends:
            topViewOffsetY = friendListSeparator + topView.frame.height + friendListVC.contentOffset.y
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
                self?.profile = profile
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
                self?.postListDataSource.updateData(objects: Bool.random() ? myPosts : Post.getMockPosts())
                if self?.state == .posts {
                    self?.updateScreen()
                }
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
                self?.likeListDataSource.updateData(objects: Bool.random() ? likedPosts : Post.getMockPosts())
                if self?.state == .likes {
                    self?.updateScreen()
                }
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
                self?.friendListDataSource.updateData(objects: Bool.random() ? friends : User.getMockUsers())
                if self?.state == .friends {
                    self?.updateScreen()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
