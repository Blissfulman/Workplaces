//
//  PostListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

import UIKit

final class PostListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var posts: [Post]
    private weak var tableViewDataSource: UITableViewDataSource?
    private weak var tableViewDelegate: UITableViewDelegate?
    
    // MARK: - Initializers
    
    init(posts: [Post], dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.posts = posts
        self.tableViewDataSource = dataSource
        self.tableViewDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
    
    // MARK: - Public methods
    
    /// Обновление постов в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter posts: Список постов для обновления.
    func updateData(posts: [Post]) {
        if self.posts != posts {
            self.posts = posts
            tableView.reloadData()
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
    }
}
