//
//  APIRequestInterceptor.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire

public final class APIRequestInterceptor: RequestInterceptor {
    
    // MARK: - Private properties
    
    private let baseURL: URL
    private let authDataStorage: AuthDataStorage
    private let tokenRefreshService: () -> TokenRefreshService
    private let retryManager: RetryManager
    private var retryCompletionStorage: RetryCompletionStorage
    
    // MARK: - Initializers
    
    /// Создаёт экземпляр `APIRequestInterceptor` с указанным базовым `URL` и токеном доступа.
    /// - Parameters:
    ///   - baseURL: Базовый `URL` для адаптера.
    ///   - authDataStorage: Хранилище авторизационных данных `AuthDataStorage`.
    ///   - tokenRefreshService: Сервис обновления токена `TokenRefreshService`.
    ///   - retryManager: Менеджер обработки повторных запросов `RetryManager`.
    ///   - retryCompletionStorage: Хранилище комплишенов для повторных запросов `RetryCompletionStorage`.
    public init(
        baseURL: URL,
        authDataStorage: AuthDataStorage,
        tokenRefreshService: @escaping () -> TokenRefreshService,
        retryManager: RetryManager,
        retryCompletionStorage: RetryCompletionStorage
    ) {
        self.baseURL = baseURL
        self.authDataStorage = authDataStorage
        self.tokenRefreshService = tokenRefreshService
        self.retryManager = retryManager
        self.retryCompletionStorage = retryCompletionStorage
    }
    
    // MARK: - Alamofire.RequestInterceptor
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard let url = urlRequest.url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = urlRequest
        request.url = appendingBaseURL(to: url)
        if let accessToken = authDataStorage.accessToken {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        if let error = error.unwrapAFError() as? HTTPError, error.statusCode == 401 {
            retryCompletionStorage.add(completion: completion)
            tryToRefreshToken()
        } else {
            retryManager.handle(request: request, error: error, completion: completion)
        }
    }
    
    // MARK: - Private methods
    
    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }
    
    private func tryToRefreshToken() {
        guard !retryCompletionStorage.getProgressState() else { return }

        retryCompletionStorage.switchProgress(to: true)
        tokenRefreshService().refreshToken { [weak self] result in
            self?.retryCompletionStorage.switchProgress(to: false)

            switch result {
            case .success:
                print("Token refresh successfully")
                self?.retryCompletionStorage.getCompletions().forEach { $0(.retry) }
            case .failure:
                print("Token refresh error")
                self?.retryCompletionStorage.getCompletions().forEach { $0(.doNotRetry) }
            }
        }
    }
}
