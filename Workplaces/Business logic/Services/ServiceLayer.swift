//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import Apexy

final class ServiceLayer {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    lazy var apiClient: Client = {
        return AlamofireClient(
            baseURL: URL(string: "https://interns2021.redmadrobot.com/")!,
            configuration: .ephemeral,
            responseObserver: { [weak self] request, response, data, error in
                self?.validateSession(responseError: error)
            }
        )
    }()
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl(apiClient: apiClient,
                                                                                   settingsStorage: settingsStorage)
    lazy var feedService: FeedService = FeedServiceImpl(apiClient: apiClient)
    lazy var newPostService: NewPostService = NewPostServiceImpl(apiClient: apiClient)
    lazy var profileService: ProfileService = ProfileServiceImpl(apiClient: apiClient)
    lazy var settingsStorage: SettingsStorage = SettingsStorageImpl(storage: UserDefaults.standard)
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Private methods
    
    private func validateSession(responseError: Error?) {
        print(responseError?.localizedDescription ?? "No error")
    }
}
