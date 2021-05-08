//
//  PostListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

import UIKit

final class PostListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var posts: [Post]
    
    // MARK: - Initializers
    
    init(posts: [Post]) {
        self.posts = posts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Public methods
    
    func reloadData(posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
    }
}

// MARK: - Table view data source

extension PostListViewController: UITableViewDataSource {
    
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
