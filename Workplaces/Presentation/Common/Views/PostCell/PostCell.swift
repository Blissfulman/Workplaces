//
//  PostCell.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

final class PostCell: UITableViewCell, CellConfigurable {
    
    typealias Object = Post
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = UIConstants.cellCornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(object: Object) {
        descriptionLabel.text = object.text
    }
}
