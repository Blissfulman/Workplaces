//
//  FriendCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

final class FriendCell: UITableViewCell, CellConfigurable {
    
    typealias Object = User
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    
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
    
    func configure(object: Object) {
        if let avatarURL = object.avatarURL {
            avatarImageView.fetchImage(byURL: avatarURL)
        }
        fullNameLabel.text = "\(object.firstName) \(object.lastName)"
        nicknameLabel.text = object.nickname
    }
}
