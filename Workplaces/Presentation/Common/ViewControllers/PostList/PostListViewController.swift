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

final class PostListViewController: UIViewController, TableViewOffsetConfigurable {
    
    // MARK: - Public properties
    
    var contentOffset: CGPoint {
        tableView?.contentOffset ?? .zero
    }
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    
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
    
    func setContentInset(contentInset: UIEdgeInsets) {
        tableView.contentInset = contentInset
    }
    
    func setTopOffset(offset: CGFloat) {
        tableView.contentOffset.y = offset
    }
    
    /// Обновление данных таблицы.
    func updateData() {
        if let tableView = tableView {
            tableView.reloadData()
            delegate?.scrollViewDidScroll(tableView)
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
    }
    
    /// Вычисление доли видимой части ячейки таблицы.
    /// - Parameter cell: Ячейка.
    /// - Returns: Доля видимой части ячейки (для полностью видимой ячейки вернётся значение 1, для полностью скрытой - 0).
    private func shareOfCellVisibility(forCell cell: UITableViewCell) -> CGFloat {
        // Значение скрытой части ячейки относительно верхнего края таблицы
        let topDelta = contentOffset.y - cell.frame.origin.y
        
        if topDelta >= 0 {
            return max(1 - topDelta / cell.frame.height, 0)
        } else {
            // Значение видимой части ячейки относительно нижнего края таблицы
            let bottomDelta = tableView.frame.height + topDelta
            return min(bottomDelta / cell.frame.height, 1)
        }
    }
}

// MARK: - Table view delegate

extension PostListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
        
        tableView.visibleCells.forEach {
            if let postCell = $0 as? PostCell {
                postCell.updateDescriptionLabelAlpha(value: shareOfCellVisibility(forCell: $0))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let postCell = cell as? PostCell {
            postCell.updateDescriptionLabelAlpha(value: shareOfCellVisibility(forCell: cell))
        }
    }
}
