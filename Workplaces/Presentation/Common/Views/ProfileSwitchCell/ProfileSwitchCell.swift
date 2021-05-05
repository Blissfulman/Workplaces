//
//  ProfileSwitchCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

final class ProfileSwitchCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var postsLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var friendsLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 20
    }
    
    // MARK: - Public methods
    
    func configure() {
        
    }
}
