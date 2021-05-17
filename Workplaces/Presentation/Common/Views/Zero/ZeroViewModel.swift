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
        title: "Oops...".localized(),
        subtitle: "Something went wrong",
        buttonTitle: "Refresh".localized()
    )
    static let feedNoFriends = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Empty".localized(),
        subtitle: "You need friends to the feed became alive".localized(),
        buttonTitle: "Find friends".localized()
    )
    static let profileNoPosts = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Empty".localized(),
        subtitle: "If you remain silent, people will never know about you".localized(),
        buttonTitle: "Create a post".localized()
    )
    static let profileNoLikes = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Empty".localized(),
        subtitle: "You haven’t put any likes yet, but you can do it from the feed".localized(),
        buttonTitle: "Go to the feed".localized()
    )
    static let profileNoFriends = ZeroViewModel(
        image: Images.noDataScreen,
        title: "Empty".localized(),
        subtitle: "You are still alone in the service, but this can be fixed".localized(),
        buttonTitle: "Find friends".localized()
    )
}
