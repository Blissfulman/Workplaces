//
//  ProfileTopView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 09.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileTopViewDelegate: AnyObject {
    func viewStateNeedChange(to newState: ProfileTopView.SegmentedControlState)
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
        topBackView?.setCornerRadius(UIConstants.cellCornerRadius)
        bottomBackView?.setCornerRadius(UIConstants.cellCornerRadius)
        avatarImageView?.setCornerRadius(UIConstants.avatarCornerRadius)
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
        delegate?.viewStateNeedChange(to: SegmentedControlState.getStateByIndex(sender.selectedSegmentIndex))
    }
}
