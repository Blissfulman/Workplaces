//
//  PostCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

// MARK: - Protocols

protocol PostCellDelegate: AnyObject {
    /// Оповещение делегата о том, что пользователь произвёл тап по кнопке лайка.
    /// - Parameter withPost: Пост, в котором произошёл тап.
    func didTapLikeButton(withPost post: Post)
}

final class PostCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    
    // MARK: - Private properties
    
    private var post: Post?
    private weak var delegate: PostCellDelegate?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.setCornerRadius(UIConstants.cellCornerRadius)
        postImageView.setCornerRadius(UIConstants.postImageCornerRadius)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(post: Post, delegate: PostCellDelegate) {
        self.post = post
        self.delegate = delegate
        
        descriptionLabel.text = post.text
        likeButton.setImage(post.liked ? Icons.liked : Icons.like, for: .normal)
    }
    
    func updateCellAlpha(value: CGFloat) {
        backView.subviews.forEach { $0.alpha = value + 0.1 }
    }
    
    // MARK: - Actions
    
    @IBAction private func likeButtonTapped() {
        guard let post = post else { return }
        delegate?.didTapLikeButton(withPost: post)
    }
}
