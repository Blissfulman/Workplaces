//
//  PostListViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

import UIKit

// MARK: - Protocols

protocol PostListViewControllerDelegate: AnyObject {
    /// Сообщает делегату, что пользователь прокручивает контент таблицы.
    func scrollViewDidScroll()
}

final class PostListViewController: BaseViewController, TableViewOffsetConfigurable {
    
    // MARK: - Public properties
    
    var topYContentPosition: CGFloat {
        guard let tableView = tableView else { return 0 }
        return tableView.frame.origin.y - tableView.contentOffset.y
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
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
    }
    
    /// Вычисление доли видимой части ячейки таблицы.
    /// - Parameter cell: Ячейка.
    /// - Returns: Доля видимой части ячейки (для полностью видимой ячейки вернётся значение 1, для полностью скрытой - 0).
    private func shareOfCellVisibility(forCell cell: UITableViewCell) -> CGFloat {
        // Значение скрытой части ячейки относительно верхнего края таблицы
        let topDelta = (tableView?.contentOffset.y ?? 0) - cell.frame.origin.y
        
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
        delegate?.scrollViewDidScroll()
        
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
