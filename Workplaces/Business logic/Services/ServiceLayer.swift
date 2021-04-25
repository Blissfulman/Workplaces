//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

final class ServiceLayer {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl()
    lazy var feedService: FeedService = FeedServiceImpl()
    lazy var newPostService: NewPostService = NewPostServiceImpl()
    lazy var profileService: ProfileService = ProfileServiceImpl()
    
    // MARK: - Initializers
    
    private init() {}
}
