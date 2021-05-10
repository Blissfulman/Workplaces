//
//  ProfileMeView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 09.05.2021.
//

import UIKit

final class ProfileMeView: NibInitializableView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var topBackView: UIView!
    @IBOutlet private weak var bottomBackView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Private properties
    
    private var editProfileButtonAction: VoidBlock?
    
    // MARK: - Initializers
    
    init(editProfileButtonAction: @escaping VoidBlock) {
        self.editProfileButtonAction = editProfileButtonAction
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UIView
    
    override func didAddSubview(_ subview: UIView) {
        topBackView?.layer.cornerRadius = UIConstants.cellCornerRadius
        bottomBackView?.layer.cornerRadius = UIConstants.cellCornerRadius
        avatarImageView?.layer.cornerRadius = UIConstants.avatarCornerRadius
    }
    
    // MARK: - Actions
    
    @IBAction private func editProfileTapped() {
        editProfileButtonAction?()
    }
}
