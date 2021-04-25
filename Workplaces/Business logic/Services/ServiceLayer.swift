//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import Foundation

final class ServiceLayer {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl(settingsStorage: settingsStorage)
    lazy var feedService: FeedService = FeedServiceImpl()
    lazy var newPostService: NewPostService = NewPostServiceImpl()
    lazy var profileService: ProfileService = ProfileServiceImpl()
    lazy var settingsStorage: SettingsStorage = SettingsStorageImpl(storage: UserDefaults.standard)
    
    // MARK: - Initializers
    
    private init() {}
}
