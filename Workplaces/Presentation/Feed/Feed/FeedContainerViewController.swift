//
//  FeedContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedContainerViewControllerDelegate: AnyObject {
    func goToSearchFriends()
}

final class FeedContainerViewController: UIViewController {
    
    // MARK: - Nested types
    
    private enum State {
        case data(posts: [Post])
        case noFriends
        case error
    }
    
    // MARK: - Public properties
    
    weak var delegate: FeedContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let feedService: FeedService
    private var progressList = [Progress]()
    
    private lazy var postListDataSource = FeedPostsDataSource(delegate: self)
    private lazy var postListVC = PostListViewController(dataSource: postListDataSource, delegate: self)
    private lazy var noFriendsZeroVC: ZeroViewController = {
        let buttonAction: VoidBlock = { [weak self] in
            self?.delegate?.goToSearchFriends()
        }
        return ZeroViewController(model: .feedNoFriends, buttonAction: buttonAction)
    }()
    private lazy var errorZeroVC: ZeroViewController = {
        let buttonAction: VoidBlock = { [weak self] in
            self?.fetchPosts()
        }
        return ZeroViewController(model: .error, buttonAction: buttonAction)
    }()
    
    private var state: State = .data(posts: []) {
        willSet {
            switch newValue {
            case let .data(posts):
                showPostListView(postList: posts)
            case .noFriends:
                showNoFriendsZeroView()
            case .error:
                showErrorZeroView()
            }
        }
    }
    
    // MARK: - Initializers
    
    init(feedService: FeedService = ServiceLayer.shared.feedService) {
        self.feedService = feedService
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
        view.backgroundColor = Palette.white
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        fetchPosts()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Популярное"
        navigationItem.backButtonTitle = ""
    }
    
    private func fetchPosts() {
        LoadingView.show()
        let progress = feedService.fetchFeedPosts { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(posts):
                self?.state = posts.isEmpty
                    ? .noFriends
                    : .data(posts: posts)
            case .failure:
                self?.state = .error
            }
        }
        progressList.append(progress)
    }
    
    private func showNoFriendsZeroView() {
        addFullover(noFriendsZeroVC)
    }
    
    private func showPostListView(postList: [Post]) {
        postListDataSource.updateData(posts: postList)
        addFullover(postListVC)
    }
    
    private func showErrorZeroView() {
        addFullover(errorZeroVC)
    }
}

// MARK: - PostListViewControllerDelegate

extension FeedContainerViewController: PostListViewControllerDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

// MARK: - FeedPostsDataSourceDelegate

extension FeedContainerViewController: FeedPostsDataSourceDelegate {
    
    func needUpdatePostList() {
        postListVC.updateData()
    }
    
    func didTapLikeButton(withPost post: Post) {
        if post.liked {
            let progress = feedService.unlikePost(postID: post.id) { [weak self] result in
                switch result {
                case .success():
                    print("Unliked!")
                    self?.fetchPosts()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            progressList.append(progress)
        } else {
            let progress = feedService.likePost(postID: post.id) { [weak self] result in
                switch result {
                case .success():
                    print("Liked!")
                    self?.fetchPosts()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            progressList.append(progress)
        }
    }
}
