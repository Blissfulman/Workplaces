//
//  FriendListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

final class FriendListViewController: UIViewController {
    
    // MARK: - Public properties
    
    /// Значение параметра `contentOffset` таблицы.
    var contentOffset: CGPoint {
        tableView.contentOffset
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var friends: [User]
    private weak var tableViewDataSource: UITableViewDataSource?
    private weak var tableViewDelegate: UITableViewDelegate?
    
    // MARK: - Initializers
    
    init(friends: [User], dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.friends = friends
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
        // Нужно создать объект для dataSource
//        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
    
    // MARK: - Public methods
    
    /// Обновление друзей в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter friends: Список друзей для обновления.
    func updateData(friends: [User]) {
        if self.friends != friends {
            self.friends = friends
            tableView.reloadData()
        }
    }
    
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
        tableView.register(FriendCell.nib(), forCellReuseIdentifier: FriendCell.identifier)
    }
}

// MARK: - Table view data source

extension FriendListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendCell.identifier,
            for: indexPath
        ) as? FriendCell else { return UITableViewCell() }
        
        cell.configure()
        return cell
    }
}
