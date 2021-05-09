//
//  FeedViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedScreenDelegate: AnyObject {
    func goToFindFriends()
}

final class FeedViewController: UIViewController {
    
    // MARK: - Nested types
    
    private enum State {
        case data(posts: [Post])
        case noFriends
        case error
    }
    
    // MARK: - Public properties
    
    weak var delegate: FeedScreenDelegate?
    
    // MARK: - Private properties
    
    private let feedService: FeedService
    private var progressList = [Progress]()
    
    private lazy var postListVC: PostListViewController = {
        let postListVC = PostListViewController(posts: [], dataSource: self, delegate: self)
        postListVC.view.frame = view.bounds
        return postListVC
    }()
    private lazy var noFriendsZeroVC: ZeroViewController = {
        let buttonAction: VoidBlock = { [weak self] in
            self?.delegate?.goToFindFriends()
        }
        let zeroVC = ZeroViewController(viewType: .noFriends, buttonAction: buttonAction)
        zeroVC.view.frame = view.bounds
        return zeroVC
    }()
    private lazy var errorZeroVC: ZeroViewController = {
        let buttonAction: VoidBlock = { [weak self] in
            self?.fetchPosts()
        }
        let zeroVC = ZeroViewController(viewType: .error, buttonAction: buttonAction)
        zeroVC.view.frame = view.bounds
        return zeroVC
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
            guard let self = self else { return }
            
            switch result {
            case let .success(posts):
                self.state = Bool.random() // posts.isEmpty
                    ? .noFriends
                    : .data(posts: posts)
            case .failure:
                self.state = .error
            }
        }
        progressList.append(progress)
    }
    
    private func showNoFriendsZeroView() {
        remove(postListVC)
        remove(errorZeroVC)
        add(noFriendsZeroVC)
    }
    
    private func showPostListView(postList: [Post]) {
        postListVC.updateData(posts: postList)
        remove(noFriendsZeroVC)
        remove(errorZeroVC)
        add(postListVC)
    }
    
    private func showErrorZeroView() {
        remove(postListVC)
        remove(noFriendsZeroVC)
        add(errorZeroVC)
    }
}

// MARK: - Table view data source

extension FeedViewController: UITableViewDataSource {
    
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

extension FeedViewController: UITableViewDelegate {
    
}
