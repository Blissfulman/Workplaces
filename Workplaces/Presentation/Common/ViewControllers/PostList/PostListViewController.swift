//
//  PostListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

import UIKit

// MARK: - Protocols

protocol PostListViewControllerDelegate: AnyObject {
    /// Сообщает делегату, когда пользователь прокручивает контент таблицы.
    /// - Parameter scrollView: Объект, в котором произошла прокрутка.
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

final class PostListViewController: UIViewController {
    
    // MARK: - Public properties
    
    /// Значение параметра `contentOffset` таблицы.
    var contentOffset: CGPoint {
        tableView.contentOffset
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var tableViewDataSource: UITableViewDataSource
    private weak var delegate: PostListViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(dataSource: UITableViewDataSource, delegate: PostListViewControllerDelegate) {
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
    
    /// Установка параметра `contentInset` для таблицы.
    /// - Parameter contentInset: Значение `contentInset`.
    func setContentInset(contentInset: UIEdgeInsets) {
        tableView.contentInset = contentInset
    }
    
    /// Установка смещения контента от верхнего края для таблицы.
    /// - Parameter topOffset: Значение смещения.
    func setTopOffset(offset: CGFloat) {
        tableView.contentOffset.y = offset
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
    }
}

// MARK: - Table view delegate

extension PostListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}

// MARK: - TableViewDataSourceDelegate

extension PostListViewController: TableViewDataSourceDelegate {
    
    func needReloadData() {
        tableView.reloadData()
    }
}
