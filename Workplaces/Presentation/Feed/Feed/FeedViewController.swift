//
//  FeedViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedScreenCoordinable {
    var didTapFindFriendButton: VoidBlock? { get set }
}

final class FeedViewController: UIViewController, FeedScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapFindFriendButton: VoidBlock?
    
    // MARK: - Private properties
    
    private let feedService: FeedService
    private var posts = [Post]()
    private var progressList = [Progress]()
    
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
        fetchPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Actions
    
    private func findFriends() {
        didTapFindFriendButton?()
    }
    
    private func errorZeroViewButtonAction() {
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
            guard let self = self else { return }
            LoadingView.hide()
            
            switch result {
            case let .success(feedPosts):
                if feedPosts.isEmpty {
                    let zeroView = ZeroView.initializeFromNib()
                    zeroView.configure(viewType: .noFriends, buttonAction: self.findFriends)
                    self.view = zeroView
                } else {
                    self.posts = feedPosts
                    self.view = UIView()
                    self.view.backgroundColor = Palette.white
                }
            case .failure:
                let zeroView = ZeroView.initializeFromNib()
                zeroView.configure(viewType: .error, buttonAction: self.errorZeroViewButtonAction)
                self.view = zeroView
            }
        }
        progressList.append(progress)
    }
}
