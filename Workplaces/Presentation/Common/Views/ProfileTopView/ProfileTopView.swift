//
//  ProfileTopView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 09.05.2021.
//

import UIKit

// MARK: - Protocols

protocol ProfileTopViewDelegate: AnyObject {
    /// Нажата кнопка редактирования профиля.
    func didTapEditProfileButton()
    /// Сообщает об изменении состояния `ProfileTopView`.
    /// - Parameter newState: Новое состояние.
    func didChangeProfileTopViewState(to newState: ProfileTopView.State)
}

final class ProfileTopView: NibInitializableView {
    
    // MARK: - Nested types
    
    enum State {
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
    
    // MARK: - Outlets
    
    @IBOutlet private var topBackView: UIView!
    @IBOutlet private var bottomBackView: UIView!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var ageLabel: UILabel!
    
    // MARK: - Private properties
    
    private var model: ProfileTopViewModel?
    private weak var delegate: ProfileTopViewDelegate?
    
    // MARK: - Initializers
    
    init(delegate: ProfileTopViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
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
    
    func configure(model: ProfileTopViewModel) {
        self.model = model
        avatarImageView.image = UIImage(data: model.avatarImageData ?? Data())
        fullNameLabel.text = model.fullName
        ageLabel.text = model.age
    }
    
    // MARK: - Actions
    
    @IBAction private func editProfileTapped() {
        delegate?.didTapEditProfileButton()
    }
    
    @IBAction private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.didChangeProfileTopViewState(to: State.getStateByIndex(sender.selectedSegmentIndex))
    }
}
