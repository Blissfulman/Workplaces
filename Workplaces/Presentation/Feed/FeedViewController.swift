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
    private let authorizationService: AuthorizationService
    private var progressList = [Progress]()
    
    // MARK: - Initializers
    
    init(
        feedService: FeedService = FeedServiceImpl(apiClient: ServiceLayer.shared.apiClient),
        authorizationService: AuthorizationService = ServiceLayer.shared.authorizationService
    ) {
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
        fetchPosts()
    }
    
    // MARK: - Actions
    
    @IBAction private func signOut() {
        authorizationService.signOut()
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            print("Window access error")
            return
        }
        sceneDelegate.applicationCoordinator.start()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = "Популярное"
    }
    
    private func fetchPosts() {
        let progress = feedService.fetchFeedPosts { result in
            switch result {
            case let .success(feedPosts):
                print(feedPosts)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        progressList.append(progress)
    }
}
