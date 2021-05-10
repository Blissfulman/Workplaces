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
    
    // MARK: - UIView
    
    override func didAddSubview(_ subview: UIView) {
        topBackView?.layer.cornerRadius = UIConstants.cellCornerRadius
        bottomBackView?.layer.cornerRadius = UIConstants.cellCornerRadius
        avatarImageView?.layer.cornerRadius = UIConstants.avatarCornerRadius
    }
    
    // MARK: - Public methods
    
    func configure(profile: User, editProfileButtonAction: @escaping VoidBlock) {
        self.editProfileButtonAction = editProfileButtonAction
        if let avatarURL = profile.avatarURL {
            avatarImageView.fetchImage(byURL: avatarURL)
        }
        fullNameLabel.text = "\(profile.firstName) \(profile.lastName)"
    }
    
    // MARK: - Actions
    
    @IBAction private func editProfileTapped() {
        editProfileButtonAction?()
    }
}
