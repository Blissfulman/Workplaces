//
//  FeedViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let feedService: FeedService
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
    
    // MARK: - Actions
    
    private func findFriends() {
        print("Find")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Популярное"
    }
    
    private func fetchPosts() {
        LoadingView.show()
        let progress = feedService.fetchFeedPosts { [weak self] result in
            LoadingView.hide()
            
            switch result {
            case let .success(feedPosts):
                if feedPosts.isEmpty {
                    let zeroView = ZeroView.initializeFromNib()
                    zeroView.configure(viewType: .noFriends, buttonAction: self?.findFriends)
                    self?.view = zeroView
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
}
