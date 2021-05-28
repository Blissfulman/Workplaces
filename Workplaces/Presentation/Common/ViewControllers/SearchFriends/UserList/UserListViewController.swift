//
//  UserListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import UIKit

final class UserListViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var tableViewDataSource: UITableViewDataSource?
    
    // MARK: - Initializers
    
    init(dataSource: UITableViewDataSource) {
        self.tableViewDataSource = dataSource
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
    }
    
    // MARK: - Public methods
    
    /// Обновление данных таблицы.
    func updateData() {
        tableView?.reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(UserCell.nib(), forCellReuseIdentifier: UserCell.identifier)
        tableView.keyboardDismissMode = .onDrag
    }
}
