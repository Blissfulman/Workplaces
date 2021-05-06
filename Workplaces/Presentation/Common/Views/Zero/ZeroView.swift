//
//  ZeroView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 24.04.2021.
//

import UIKit

final class ZeroView: NibInitializableView {
    
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
    
    private var viewType: ViewType?
    private var buttonAction: VoidBlock?
    
    // MARK: - Initializers
    
    convenience init(viewType: ViewType, buttonAction: VoidBlock? = nil) {
        self.init(frame: .zero)
        self.viewType = viewType
        self.buttonAction = buttonAction
    }
    
    override func layoutSubviews() {
        guard let viewType = viewType else { return }
        
        subviews.forEach {
            if let zeroSubview = $0 as? ZeroView {
                zeroSubview.buttonAction = buttonAction
                zeroSubview.configure(viewType: viewType, buttonAction: buttonAction)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func buttonTapped() {
        buttonAction?()
    }
    
    // MARK: - Private methods
    
    private func configure(viewType: ViewType, buttonAction: VoidBlock? = nil) {
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
        if buttonAction != nil {
            button.isHidden = false
        }
    }
}
