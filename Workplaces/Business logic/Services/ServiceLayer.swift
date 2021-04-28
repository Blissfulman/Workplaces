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
        let interceptor = AuthRequestInterceptor(baseURL: Constants.apiBaseURL, accessToken: { self.accessToken })
        
        return AlamofireClient(
            requestInterceptor: interceptor,
            configuration: .ephemeral,
            responseObserver: { [weak self] _, _, _, error in
                self?.validateSession(responseError: error)
            }
        )
    }()
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl(apiClient: apiClient,
                                                                                   authDataStorage: authDataStorage)
    lazy var feedService: FeedService = FeedServiceImpl(apiClient: apiClient)
    lazy var newPostService: NewPostService = NewPostServiceImpl(apiClient: apiClient)
    lazy var profileService: ProfileService = ProfileServiceImpl(apiClient: apiClient)
    
    lazy var authDataStorage: AuthDataStorage = AuthDataStorageImpl(storage: UserDefaults.standard)
    
    // MARK: - Private properties
    
    private var accessToken: String? {
        authDataStorage.accessToken
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Private methods
    
    private func validateSession(responseError: Error?) {
        if let error = responseError as? APIError, error.code == .tokenInvalid {
//            authorizationService.signOut { _ in }
        }
    }
}
