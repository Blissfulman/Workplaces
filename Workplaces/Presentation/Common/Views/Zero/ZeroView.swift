//
//  ZeroView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

final class ZeroView: UIView, NibInitializable {
    
    // MARK: - Nested types
    
    public enum ViewType {
        case error
        case noData
        case noFriends
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Private properties
    
    private var buttonAction: VoidBlock?
    
    // MARK: - Public methods
    
    func configure(viewType: ViewType, buttonAction: VoidBlock? = nil) {
        switch viewType {
        case .error:
            imageView.image = Images.errorScreen
            titleLabel.text = "Упс..."
            subtitleLabel.text = "Что-то пошло не так"
            button.setTitle("Обновить", for: .normal)
        case .noData:
            imageView.image = Images.noDataScreen
            titleLabel.text = "Пустота"
            subtitleLabel.text = "Если молчать, люди никогда не узнают о вас"
            button.setTitle("Создать пост", for: .normal)
        case .noFriends:
            imageView.image = Images.noDataScreen
            titleLabel.text = "Пустота"
            subtitleLabel.text = "Вам нужны друзья, чтобы лента стала живой"
            button.setTitle("Найти друзей", for: .normal)
        }
        if let buttonAction = buttonAction {
            self.buttonAction = buttonAction
            button.isHidden = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func buttonTapped() {
        buttonAction?()
    }
}
