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
    private let accessToken: () -> String
    private let retryRequestManager: RetryRequestManager
    
    // MARK: - Initializers
    
    /// Создаёт экземпляр `APIRequestInterceptor`.
    /// - Parameters:
    ///   - baseURL: Базовый `URL` для адаптера.
    ///   - securityManager: Менеджер безопасности `SecurityManager`.
    ///   - retryRequestManager: Менеджер обработки повторных запросов `RetryRequestService`.
    public init(baseURL: URL, accessToken: @escaping () -> String, retryRequestManager: RetryRequestManager) {
        self.baseURL = baseURL
        self.accessToken = accessToken
        self.retryRequestManager = retryRequestManager
    }
    
    // MARK: - RequestInterceptor
    
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
        request.addValue("Bearer \(accessToken())", forHTTPHeaderField: "Authorization")
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
