//
//  FeedPostsDataSource.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FeedPostsDataSourceDelegate: AnyObject {
    /// Оповещение делегата о необходимости обновления данных.
    func needUpdatePostList()
    /// Оповещение делегата о том, что пользователь произвёл тап по кнопке лайка.
    /// - Parameter withPost: Пост, в котором произошёл тап.
    func didTapLikeButton(withPost post: Post)
}

final class FeedPostsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public properties
    
    var isEmptyData: Bool {
        posts.isEmpty
    }
    weak var delegate: FeedPostsDataSourceDelegate?
    
    // MARK: - Private properties
    
    private var posts = [Post]()
    
    // MARK: - Initializers
    
    init(delegate: FeedPostsDataSourceDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostCell.identifier,
            for: indexPath
        ) as? PostCell else { return UITableViewCell() }
        cell.configure(model: PostCellModel(post: posts[indexPath.row]), delegate: self)
        return cell
    }
    
    // MARK: - Public methods
    
    /// Обновление постов в таблице, если переданные данные отличаются от уже имеющихся.
    /// - Parameter posts: Массив постов для обновления.
    func updateData(posts: [Post]) {
        if self.posts != posts {
            self.posts = posts
            delegate?.needUpdatePostList()
        }
    }
}

// MARK: - PostCellDelegate

extension FeedPostsDataSource: PostCellDelegate {
    
    func didTapLikeButton(withPost post: Post) {
        delegate?.didTapLikeButton(withPost: post)
    }
}
