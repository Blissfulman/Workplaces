//
//  SearchFriendsContainerViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 14.05.2021.
//

import UIKit

final class SearchFriendsContainerViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: - Private properties
    
    private let searchService: SearchService
    private let profileService: ProfileService
    private var progressList = [Progress]()
    private lazy var searchFriendsVC = SearchFriendsViewController(delegate: self)
    private lazy var userListDataSource = UserListDataSource(delegate: self)
    private lazy var userListVC = UserListViewController(dataSource: userListDataSource, delegate: self)
    
    // MARK: - Initializers
    
    init(
        searchService: SearchService = ServiceLayer.shared.searchService,
        profileService: ProfileService = ServiceLayer.shared.profileService
    ) {
        self.searchService = searchService
        self.profileService = profileService
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
        stackView.addArrangedSubview(searchFriendsVC.view)
    }
    
    private func showUserList() {
        stackView.addArrangedSubview(userListVC.view)
    }
    
    private func hideUserList() {
        stackView.removeArrangedSubview(userListVC.view)
    }
}

// MARK: - SearchFriendsViewControllerDelegate

extension SearchFriendsContainerViewController: SearchFriendsViewControllerDelegate {
    
    func didTapSearchButton(query: String) {
        searchService.searchUsers(query: query) { [weak self] result in
            switch result {
            case let .success(users):
                self?.userListDataSource.updateData(users: users)
                users.isEmpty
                    ? self?.hideUserList()
                    : self?.showUserList()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UserListViewControllerDelegate

extension SearchFriendsContainerViewController: UserListViewControllerDelegate {
    
    func needEndEditing() {
        view.endEditing(true)
    }
}

// MARK: - UserListDataSourceDelegate

extension SearchFriendsContainerViewController: UserListDataSourceDelegate {
    
    func needUpdateUserList() {
        userListVC.updateData()
    }
    
    func didTapAddFriend(withID userID: User.ID) {
        let progress = profileService.addFriend(userID: userID) { result in
            if case let .failure(error) = result {
                print(error.localizedDescription) // TEMP
            }
        }
        progressList.append(progress)
    }
}
