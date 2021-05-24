//
//  AuthRequestInterceptor.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire

public final class AuthRequestInterceptor: Alamofire.RequestInterceptor {
    
    // MARK: - Typealiases
    
    typealias RetryCompletion = (RetryResult) -> Void
    
    // MARK: - Private properties
    
    private let baseURL: URL
    private let authDataStorage: AuthDataStorage
    private let tokenRefreshService: () -> TokenRefreshService
    private var retryCompletions = [RetryCompletion]()
    private var isInProgressRefreshingToken = false
    
    // MARK: - Initializers
    
    /// Создаёт экземпляр `AuthRequestInterceptor` с указанным базовым `URL` и токеном доступа.
    /// - Parameters:
    ///   - baseURL: Базовый `URL` для адаптера.
    ///   - authDataStorage: Хранилище авторизационных данных `AuthDataStorage`.
    ///   - tokenRefreshService: Сервис обновления токена `TokenRefreshService`.
    public init(
        baseURL: URL,
        authDataStorage: AuthDataStorage,
        tokenRefreshService: @escaping () -> TokenRefreshService
    ) {
        self.baseURL = baseURL
        self.authDataStorage = authDataStorage
        self.tokenRefreshService = tokenRefreshService
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
            retryCompletions.append(completion)
            tryToRefreshToken()
        } else {
            return completion(.doNotRetry)
        }
    }
    
    // MARK: - Private methods
    
    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }
    
    private func tryToRefreshToken() {
        // !!! Нужно доработать потокобезопасность
        guard !isInProgressRefreshingToken else { return }
        
        isInProgressRefreshingToken = true
        tokenRefreshService().refreshToken { [weak self] result in
            self?.isInProgressRefreshingToken = false
            
            switch result {
            case .success:
                self?.retryCompletions.forEach {
                    $0(.retry)
                }
            case .failure:
                self?.retryCompletions.forEach {
                    $0(.doNotRetry)
                }
            }
            self?.retryCompletions = []
        }
    }
}

// MARK: - Extensions

fileprivate extension Error {
    
    /// Разворачивает ошибку валидации из Alamofire.
    func unwrapAFError() -> Error {
        guard let afError = asAFError else { return self }
        if case .responseValidationFailed(let reason) = afError,
           case .customValidationFailed(let underlyingError) = reason {
            return underlyingError
        }
        return self
    }
}
