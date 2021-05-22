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
    
    @IBOutlet private var topBackView: UIView!
    @IBOutlet private var bottomBackView: UIView!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var ageLabel: UILabel!
    
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
        
        // Временная реализация получения картинки
        if let avatarURL = profile.avatarURL,
           let data = try? Data(contentsOf: avatarURL),
           let imageData = Data(base64Encoded: data) {
            avatarImageView.image = UIImage(data: imageData)
        }
        fullNameLabel.text = "\(profile.firstName) \(profile.lastName)"
        if let age = profile.birthday.getAgeFromBirthday() {
            ageLabel.text = "\(age) years"
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func editProfileTapped() {
        editProfileButtonAction?()
    }
    
    @IBAction private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.viewStateNeedChange(to: SegmentedControlState.getStateByIndex(sender.selectedSegmentIndex))
    }
}

fileprivate extension Date {
    
    func getAgeFromBirthday() -> Int? {
        Calendar.current.dateComponents([.year], from: self, to: Date()).year
    }
}
