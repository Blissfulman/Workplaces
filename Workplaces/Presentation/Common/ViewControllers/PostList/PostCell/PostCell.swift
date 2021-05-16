//
//  PostCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

// MARK: - Protocols

protocol PostCellDelegate: AnyObject {
    
}

final class PostCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    
    // MARK: - Private properties
    
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
        descriptionLabel.text = post.text
        self.delegate = delegate
    }
}
