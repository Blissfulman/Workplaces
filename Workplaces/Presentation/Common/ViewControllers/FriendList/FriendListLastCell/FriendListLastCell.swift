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
    
    @IBOutlet private weak var findMoreFriendsButton: UIButton!
    
    // MARK: - Private properties
    
    private weak var delegate: FriendListLastCellDelegate?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGestureRecognizer()
    }
    
    // MARK: - Public methods
    
    func configure(delegate: FriendListLastCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc private func findMoreFriendsButtonTapped() {
        delegate?.didTapFindMoreFriendsButton()
    }
    
    // MARK: - Private methods
    
    private func setupGestureRecognizer() {
        let findMoreFriendsButtonGR = UITapGestureRecognizer(
            target: self,
            action: #selector(findMoreFriendsButtonTapped)
        )
        findMoreFriendsButton.addGestureRecognizer(findMoreFriendsButtonGR)
    }
}
