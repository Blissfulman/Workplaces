//
//  UserListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import UIKit

// MARK: - Protocols

protocol UserListViewControllerDelegate: AnyObject {
    func needEndEditing()
}

final class UserListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var tableViewDataSource: UITableViewDataSource?
    private weak var delegate: UserListViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(dataSource: UITableViewDataSource, delegate: UserListViewControllerDelegate) {
        self.tableViewDataSource = dataSource
        self.delegate = delegate
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
    }
}

extension UserListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.needEndEditing()
    }
}
