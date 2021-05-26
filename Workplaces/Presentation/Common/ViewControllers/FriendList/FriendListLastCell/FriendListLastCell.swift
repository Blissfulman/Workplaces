//
//  FriendListLastCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 13.05.2021.
//

import UIKit

// MARK: - Protocols

protocol FriendListLastCellDelegate: AnyObject {
    func didTapFindMoreFriendsButton()
}

final class FriendListLastCell: UITableViewCell {
            
    // MARK: - Outlets
    
    @IBOutlet private var findMoreFriendsButton: UIButton!
    
    // MARK: - Private properties
    
    private weak var delegate: FriendListLastCellDelegate?
    
    // MARK: - Public methods
    
    func configure(delegate: FriendListLastCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @IBAction private func action() {
        delegate?.didTapFindMoreFriendsButton()
    }
}
