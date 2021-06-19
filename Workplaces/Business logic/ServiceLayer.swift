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
        let interceptor = APIRequestInterceptor(
            baseURL: Constants.apiBaseURL,
            accessToken: { self.accessToken },
            retryRequestManager: retryRequestManager
        )
        
        return AlamofireClient(
            requestInterceptor: interceptor,
            configuration: .ephemeral,
            responseObserver: { _, _, _, error in
                self.validateSession(responseError: error)
            }
        )
    }()
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl(
        apiClient: apiClient,
        securityManager: securityManager
    )
    lazy var feedService: FeedService = FeedServiceImpl(apiClient: apiClient)
    lazy var newPostService: NewPostService = NewPostServiceImpl(apiClient: apiClient)
    lazy var profileService: ProfileService = ProfileServiceImpl(apiClient: apiClient)
    lazy var searchService: SearchService = SearchServiceImpl(apiClient: apiClient)
    lazy var tokenRefreshService: TokenRefreshService = TokenRefreshServiceImpl(
        apiClient: apiClient,
        securityManager: securityManager
    )
    
    lazy var securityManager: SecurityManager = SecurityManagerImpl()
    lazy var keychainStorage: KeychainStorage = KeychainStorageImpl()
    
    // MARK: - Private properties
    
    // tokenRefreshService передаётся по ссылке, чтобы не было зацикливания с инициализацией apiClient
    private lazy var retryRequestManager: RetryRequestManager = RetryRequestManagerImpl(
        tokenRefreshService: { self.tokenRefreshService },
        retryCompletionStorage: retryCompletionStorage
    )
    private lazy var retryCompletionStorage: RetryCompletionStorage = RetryCompletionStorageImpl()
    private var accessToken: String? {
        securityManager.accessToken
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Private methods
    
    private func validateSession(responseError: Error?) {
        if let error = responseError as? APIError, error.code == .tokenInvalid {
            // ? Добавить выход на сценарий авторизации
            securityManager.logoutReset()
        }
    }
}
