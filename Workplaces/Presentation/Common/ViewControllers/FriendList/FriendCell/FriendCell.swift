//
//  FriendCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FriendCellDelegate: AnyObject {
    
}

final class FriendCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    
    // MARK: - Private properties
    
    weak var delegate: FriendCellDelegate?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = UIConstants.cellCornerRadius
        avatarImageView.layer.cornerRadius = UIConstants.avatarCornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        fullNameLabel.text = nil
        nicknameLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(user: User, delegate: FriendCellDelegate) {
        if let avatarURL = user.avatarURL {
            avatarImageView.fetchImage(byURL: avatarURL)
        }
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        nicknameLabel.text = user.nickname
        self.delegate = delegate
    }
}
