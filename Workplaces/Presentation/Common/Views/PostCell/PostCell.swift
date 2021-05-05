//
//  PostCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

final class PostCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = UIConstants.cellCornerRadius
    }
    
    // MARK: - Public methods
    
    func configure() {
        
    }
}
