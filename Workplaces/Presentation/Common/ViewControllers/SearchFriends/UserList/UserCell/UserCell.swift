//
//  UserCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import UIKit

// MARK: - Protocols

protocol UserCellDelegate: AnyObject {
    func didTapAddFriend(withID userID: User.ID)
}

final class UserCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    
    // MARK: - Private properties
    
    private weak var delegate: UserCellDelegate?
    private var user: User?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.setCornerRadius(UIConstants.avatarCornerRadius)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        fullNameLabel.text = nil
        nicknameLabel.text = nil
    }
    
    // MARK: - Actions
    
    @IBAction private func addFriendButtonTapped() {
        delegate?.didTapAddFriend(withID: user?.id ?? "")
    }
    
    // MARK: - Public methods
    
    func configure(user: User, delegate: UserCellDelegate) {
        self.user = user
        self.delegate = delegate
        
        if let avatarURL = user.avatarURL {
            avatarImageView.fetchImage(byURL: avatarURL)
        }
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
        nicknameLabel.text = user.nickname
    }
}
