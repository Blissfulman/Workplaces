//
//  ZeroViewModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import UIKit

struct ZeroViewModel {
    
    // MARK: - Public properties
    
    let image: UIImage?
    let title: String?
    let subtitle: String?
    let buttonTitle: String?
}

// MARK: - Extensions

extension ZeroViewModel {
    
    // MARK: - Static properties
    
    static let error = ZeroViewModel(
        image: Images.errorScreen,
        title: "Упс...",
        subtitle: "Что-то пошло не так",
        buttonTitle: "Обновить"
    )
    static let feedNoFriends = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Пустота",
        subtitle: "Вам нужны друзья, чтобы лента стала живой",
        buttonTitle: "Найти друзей"
    )
    static let profileNoPosts = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Пустота",
        subtitle: "Если молчать, люди никогда не узнают о вас",
        buttonTitle: "Создать пост"
    )
    static let profileNoLikes = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Пустота",
        subtitle: "Вы ещё не поставили ни одного лайка, но можете из ленты",
        buttonTitle: "Перейти к ленте"
    )
    static let profileNoFriends = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Пустота",
        subtitle: "Вы пока одиноки в сервисе, но это можно исправить",
        buttonTitle: "Найти друзей"
    )
}
