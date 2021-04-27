//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import Apexy
import WorkplacesAPI

final class ServiceLayer {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    lazy var apiClient: Client = {
        AlamofireClient(
            requestInterceptor: AuthRequestInterceptor(baseURL: Constants.apiBaseURL, accessToken: accessToken),
            configuration: .ephemeral,
            responseObserver: { [weak self] _, _, _, error in
                self?.validateSession(responseError: error)
            }
        )
    }()
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl(
        apiClient: apiClient, authDataStorage: authDataStorage, settingsStorage: settingsStorage
    )
    lazy var feedService: FeedService = FeedServiceImpl(apiClient: apiClient)
    lazy var newPostService: NewPostService = NewPostServiceImpl(apiClient: apiClient)
    lazy var profileService: ProfileService = ProfileServiceImpl(apiClient: apiClient)
    
    lazy var settingsStorage: SettingsStorage = SettingsStorageImpl(storage: UserDefaults.standard)
    lazy var authDataStorage: AuthDataStorage = AuthDataStorageImpl(storage: UserDefaults.standard)
    
    // MARK: - Private properties
    
    var accessToken: String {
        return authDataStorage.getAccessToken()
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Private methods
    
    private func validateSession(responseError: Error?) {
        print(responseError?.localizedDescription ?? "No error")
    }
}
