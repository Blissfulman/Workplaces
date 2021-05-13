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
    
    // MARK: - Private properties
    
    weak var delegate: PostCellDelegate?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = UIConstants.cellCornerRadius
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
