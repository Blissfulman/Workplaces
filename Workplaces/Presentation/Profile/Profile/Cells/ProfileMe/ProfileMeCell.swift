//
//  ProfileMeCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

final class ProfileMeCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 24
        avatarImageView.layer.cornerRadius = 16
    }
    
    // MARK: - Public methods
    
    func configure(user: User?) {
        fullNameLabel.text = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
    }
}
