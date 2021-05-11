//
//  ProfileTopView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 09.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileTopViewDelegate: AnyObject {
    func segmentedControlValueChanged(to segmentedControlState: ProfileTopView.SegmentedControlState)
}

final class ProfileTopView: NibInitializableView {
    
    // MARK: - Nested types
    
    enum SegmentedControlState {
        case posts
        case likes
        case friends
        
        fileprivate static func getStateByIndex(_ index: Int) -> Self {
            switch index {
            case 0:
                return .posts
            case 1:
                return .likes
            case 2:
                return .friends
            default:
                assertionFailure("Function \(#function) error")
                return .posts
            }
        }
    }
    
    // MARK: - Public properties
    
    weak var delegate: ProfileTopViewDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var topBackView: UIView!
    @IBOutlet private weak var bottomBackView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    // MARK: - Private properties
    
    private var editProfileButtonAction: VoidBlock?
    
    // MARK: - Initializers
    
    init(delegate: ProfileTopViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
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
    
    @IBAction private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentedControlValueChanged(to: SegmentedControlState.getStateByIndex(sender.selectedSegmentIndex))
    }
}
