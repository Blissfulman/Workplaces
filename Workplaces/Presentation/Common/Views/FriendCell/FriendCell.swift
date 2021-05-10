//
//  FriendCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

final class FriendCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = UIConstants.cellCornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Добавить реализацию
    }
    
    // MARK: - Public methods
    
    func configure() {
        
    }
}
