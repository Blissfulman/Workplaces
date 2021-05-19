//
//  FriendCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FriendCellDelegate: AnyObject {
    func didTapDeleteFriend(withID userID: User.ID)
}

final class FriendCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    
    // MARK: - Private properties
    
    private weak var delegate: FriendCellDelegate?
    private var user: User?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.setCornerRadius(UIConstants.cellCornerRadius)
        avatarImageView.setCornerRadius(UIConstants.avatarCornerRadius)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = Icons.avatar
        fullNameLabel.text = nil
        nicknameLabel.text = nil
    }
    
    // MARK: - Actions
    
    @IBAction private func deleteFriendButtonTapped() {
        delegate?.didTapDeleteFriend(withID: user?.id ?? "")
    }
    
    // MARK: - Public methods
    
    func configure(user: User, delegate: FriendCellDelegate) {
        self.user = user
        self.delegate = delegate
        
        if let avatarURL = user.avatarURL {
            avatarImageView.fetchImage(byURL: avatarURL)
        }
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        nicknameLabel.text = user.nickname
    }
}
