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
    private let retryRequestManager: RetryRequestManager
    
    // MARK: - Initializers
    
    /// Создаёт экземпляр `APIRequestInterceptor` с указанным базовым `URL` и токеном доступа.
    /// - Parameters:
    ///   - baseURL: Базовый `URL` для адаптера.
    ///   - authDataStorage: Хранилище авторизационных данных `AuthDataStorage`.
    ///   - retryRequestManager: Менеджер обработки повторных запросов `RetryRequestService`.
    public init(
        baseURL: URL,
        authDataStorage: AuthDataStorage,
        retryRequestManager: RetryRequestManager
    ) {
        self.baseURL = baseURL
        self.authDataStorage = authDataStorage
        self.retryRequestManager = retryRequestManager
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
        retryRequestManager.handle(request, dueTo: error, completion: completion)
    }
    
    // MARK: - Private methods
    
    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }
}
