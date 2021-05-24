//
//  ProfileContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileContainerViewControllerDelegate: AnyObject {
    func goToEditProfile(profile: User)
    func goToNewPost()
    func goToFeed()
    func goToSearchFriends()
    func signOut()
}

final class ProfileContainerViewController: UIViewController {
    
    // MARK: - Nested types
    
    enum State {
        case posts
        case likes
        case friends
    }
    
    // MARK: - Public properties
    
    weak var delegate: ProfileContainerViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private var topView: UIView!
    @IBOutlet private var zeroView: UIView!
    
    // MARK: - Private properties
    
    private let profileService: ProfileService
    private let feedService: FeedService
    private let authorizationService: AuthorizationService
    private var profile: User?
    private lazy var postListDataSource = ProfilePostsDataSource(delegate: self)
    private lazy var likeListDataSource = ProfileLikesDataSource(delegate: self)
    private lazy var friendListDataSource = ProfileFriendsDataSource(delegate: self)
    
    /// Толщина разделителя между верхним вью и списком друзей.
    private let friendListSeparator: CGFloat = 9
    private var topViewHeight: CGFloat { topView.frame.height }
    private var progressList = [Progress]()
    
    private lazy var profileTopView: ProfileTopView = {
        let profileTopView = ProfileTopView(delegate: self)
        topView.addFulloverSubview(profileTopView)
        return profileTopView
    }()
    private lazy var postListVC = PostListViewController(dataSource: postListDataSource, delegate: self)
    private lazy var likeListVC = PostListViewController(dataSource: likeListDataSource, delegate: self)
    private lazy var friendListVC = FriendListViewController(dataSource: friendListDataSource, delegate: self)
    
    private var state: State = .posts {
        didSet {
            updateScreen()
        }
    }
    
    // MARK: - Initializers
    
    init(
        profileService: ProfileService = ServiceLayer.shared.profileService,
        feedService: FeedService = ServiceLayer.shared.feedService,
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService
    ) {
        self.profileService = profileService
        self.feedService = feedService
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
        tabBarController?.tabBar.showTransparent()
        fetchProfile()
        fetchMyPosts()
        fetchLikedPosts()
        fetchFriends()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.alpha = 1
    }
    
    // MARK: - Actions
    
    @objc private func logOutBarButtonTapped() {
        let progress = authorizationService.signOut { [weak self] result in
            if case .success = result {
                self?.delegate?.signOut()
            }
        }
        progressList.append(progress)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
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
        addFullover(friendListVC)
        friendListVC.setContentInset(
            contentInset: UIEdgeInsets(top: topViewHeight + friendListSeparator, left: 0, bottom: 0, right: 0)
        )
        addFullover(likeListVC)
        likeListVC.setContentInset(contentInset: UIEdgeInsets(top: topViewHeight, left: 0, bottom: 0, right: 0))
        addFullover(postListVC)
        postListVC.setContentInset(contentInset: UIEdgeInsets(top: topViewHeight, left: 0, bottom: 0, right: 0))
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
        profileTopView.configure(
            model: ProfileTopViewModel(profile: profile),
            editProfileButtonAction: editProfileButtonAction
        )
    }
    
    private func showPostList() {
        if postListDataSource.isEmptyData {
            showZeroView()
        } else {
            postListVC.setTopOffset(offset: -topViewHeight)
            addFullover(postListVC)
        }
    }
    
    private func showLikeList() {
        if likeListDataSource.isEmptyData {
            showZeroView()
        } else {
            likeListVC.setTopOffset(offset: -topViewHeight)
            addFullover(likeListVC)
        }
    }
    
    private func showFriendList() {
        if friendListDataSource.isEmptyData {
            showZeroView()
        } else {
            friendListVC.setTopOffset(offset: -(topViewHeight + friendListSeparator))
            addFullover(friendListVC)
        }
    }
    
    private func showZeroView() {
        var zeroSubview: ZeroView?
        
        switch state {
        case .posts:
            let buttonAction: VoidBlock = { [weak self] in
                self?.delegate?.goToNewPost()
            }
            zeroSubview = ZeroView(model: .profileNoPosts, buttonAction: buttonAction)
        case .likes:
            let buttonAction: VoidBlock = { [weak self] in
                self?.delegate?.goToFeed()
            }
            zeroSubview = ZeroView(model: .profileNoLikes, buttonAction: buttonAction)
        case .friends:
            let buttonAction: VoidBlock = { [weak self] in
                self?.delegate?.goToSearchFriends()
            }
            zeroSubview = ZeroView(model: .profileNoFriends, buttonAction: buttonAction)
        }
        
        if let zeroSubview = zeroSubview {
            zeroView.subviews.forEach { $0.removeFromSuperview() }
            zeroView.addFulloverSubview(zeroSubview)
            view.bringSubviewToFront(zeroView)
        }
    }
}

// MARK: - Data fetching methods

extension ProfileContainerViewController {
    
    private func fetchProfile() {
        LoadingView.show()
        
        let progress = profileService.fetchMyProfile { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(profile):
                self?.profile = profile
                self?.navigationItem.title = profile.nickname
                self?.configureProfileTopView()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
    
    private func fetchMyPosts() {
        LoadingView.show()

        let progress = profileService.fetchMyPosts { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(myPosts):
                self?.postListDataSource.updateData(posts: myPosts)
                if self?.state == .posts {
                    self?.updateScreen()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
    
    private func fetchLikedPosts() {
        LoadingView.show()

        let progress = profileService.fetchLikedPosts { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(likedPosts):
                self?.likeListDataSource.updateData(posts: likedPosts)
                if self?.state == .likes {
                    self?.updateScreen()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
    
    private func fetchFriends() {
        LoadingView.show()

        let progress = profileService.fetchFriends { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(friends):
                self?.friendListDataSource.updateData(friends: friends)
                if self?.state == .friends {
                    self?.updateScreen()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
}

// MARK: - ProfileTopViewDelegate

extension ProfileContainerViewController: ProfileTopViewDelegate {
    
    func viewStateNeedChange(to newState: ProfileTopView.SegmentedControlState) {
        switch newState {
        case .posts:
            fetchMyPosts()
            state = .posts
        case .likes:
            fetchLikedPosts()
            state = .likes
        case .friends:
            fetchFriends()
            state = .friends
        }
    }
}

// MARK: - PostListViewControllerDelegate, FriendListViewControllerDelegate

extension ProfileContainerViewController: PostListViewControllerDelegate, FriendListViewControllerDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var topViewOffsetY: CGFloat = 0
        switch state {
        case .posts:
            topViewOffsetY = postListVC.contentOffset.y
        case .likes:
            topViewOffsetY = likeListVC.contentOffset.y
        case .friends:
            topViewOffsetY = friendListSeparator + friendListVC.contentOffset.y
        }
        topView.frame.origin.y = scrollView.frame.origin.y - topViewOffsetY - topViewHeight
    }
}

// MARK: - ProfilePostsDataSourceDelegate

extension ProfileContainerViewController: ProfilePostsDataSourceDelegate {
    
    func needUpdatePostList() {
        postListVC.updateData()
    }
    
    func didTapLikeButtonInPostList(withPost post: Post) {
        let likeAction = post.liked ? feedService.unlikePost : feedService.likePost
        
        let progress = likeAction(post.id) { [weak self] result in
            switch result {
            case .success:
                self?.fetchMyPosts()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
}

// MARK: - ProfileLikesDataSourceDelegate

extension ProfileContainerViewController: ProfileLikesDataSourceDelegate {
    
    func needUpdateLikeList() {
        likeListVC.updateData()
    }
    
    func didTapLikeButtonInLikeList(withPost post: Post) {
        let likeAction = post.liked ? feedService.unlikePost : feedService.likePost
        
        let progress = likeAction(post.id) { [weak self] result in
            switch result {
            case .success:
                self?.fetchLikedPosts()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
}

// MARK: - ProfileFriendsDataSourceDelegate

extension ProfileContainerViewController: ProfileFriendsDataSourceDelegate {
    
    func needUpdateFriendList() {
        friendListVC.updateData()
    }
    
    func didTapFindMoreFriendsButton() {
        delegate?.goToSearchFriends()
    }
    
    func didTapDeleteFriend(withID userID: User.ID) {
        let progress = profileService.removeFriend(userID: userID) { [weak self] result in
            switch result {
            case .success:
                self?.fetchFriends()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
}
