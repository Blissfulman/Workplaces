//
//  SearchFriendsContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 14.05.2021.
//

import UIKit

// MARK: - Protocols

protocol SearchFriendsContainerViewControllerDelegate: AnyObject {
    func didTapSearchButton()
    func didTapAddFriend()
}

final class SearchFriendsContainerViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SearchFriendsContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private let searchService: SearchService
    private var progressList = [Progress]()
    private lazy var searchFriendsVC: SearchFriendsViewController = {
        let searchFriendsVC = SearchFriendsViewController(delegate: self)
        searchFriendsVC.view.frame = view.bounds
        return searchFriendsVC
    }()
    
    // MARK: - Initializers
    
    init(searchService: SearchService = ServiceLayer.shared.searchService) {
        self.searchService = searchService
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
    
    // MARK: - Private methods
    
    private func setupUI() {
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "Поиск друзей"
        add(searchFriendsVC)
    }
}

// MARK: - SearchFriendsViewControllerDelegate

extension SearchFriendsContainerViewController: SearchFriendsViewControllerDelegate {
    
    func didTapSearchButton(query: String) {
        searchService.searchUsers(query: query) { result in
            switch result {
            case let .success(users):
                print(users)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
