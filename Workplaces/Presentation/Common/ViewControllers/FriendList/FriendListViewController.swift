//
//  FriendListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FriendListViewControllerDelegate: AnyObject {
    /// Сообщает делегату, что пользователь прокручивает контент таблицы.
    func scrollViewDidScroll()
}

final class FriendListViewController: BaseViewController, TableViewOffsetConfigurable {
    
    // MARK: - Public properties
    
    var topYContentPosition: CGFloat {
        guard let tableView = tableView else { return 0 }
        return tableView.frame.origin.y - tableView.contentOffset.y
    }
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var tableViewDataSource: UITableViewDataSource?
    private weak var delegate: FriendListViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(dataSource: UITableViewDataSource, delegate: FriendListViewControllerDelegate) {
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
    
    func setInitialVerticalOffset(_ offset: CGFloat) {
        tableView?.contentInset.top = offset
    }
    
    func resetToInitialOffset() {
        tableView.contentOffset.y = -tableView.contentInset.top
    }
    
    /// Обновление данных таблицы.
    func updateData() {
        tableView?.reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(FriendCell.nib(), forCellReuseIdentifier: FriendCell.identifier)
        tableView.register(FriendListLastCell.nib(), forCellReuseIdentifier: FriendListLastCell.identifier)
    }
}

// MARK: - Table view delegate

extension FriendListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}
