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
    
    @IBOutlet private var backView: UIView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var locationStackView: UIStackView!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!
    
    // MARK: - Private properties
    
    private var model: PostCellModel?
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
        authorLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(model: PostCellModel, delegate: PostCellDelegate) {
        self.model = model
        self.delegate = delegate
        
        descriptionLabel.text = model.post.text
        locationStackView.isHidden = model.isHiddenLocation
        locationLabel.text = model.location
        postImageView.isHidden = model.isHiddenPostImage
        postImageView.image = UIImage(data: model.postImageData ?? Data())
        authorLabel.text = model.nickname
        likeButton.setImage(model.post.liked ? Icons.liked : Icons.like, for: .normal)
    }
    
    func updateDescriptionLabelAlpha(value: CGFloat) {
        descriptionLabel.alpha = value
    }
    
    // MARK: - Actions
    
    @IBAction private func likeButtonTapped() {
        guard let model = model else { return }
        
        likeButton.likeAnimation { [weak self] in
            self?.delegate?.didTapLikeButton(withPost: model.post)
        }
    }
}
