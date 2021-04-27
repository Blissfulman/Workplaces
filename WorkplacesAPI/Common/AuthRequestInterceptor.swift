//
//  AuthRequestInterceptor.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire

/// Implementation of Alamofire.RequestInterceptor.
public final class AuthRequestInterceptor: Alamofire.RequestInterceptor {
    
    // MARK: - Private properties
    
    private let baseURL: URL
    private let accessToken: String
    
    // MARK: - Initializers
    
    /// Creates an `AuthRequestInterceptor` instance with specified base `URL` and access token.
    /// - Parameters:
    ///   - baseURL: Базовый `URL` для адаптора.
    ///   - accessToken: Токен доступа для адаптора.
    public init(baseURL: URL, accessToken: String) {
        self.baseURL = baseURL
        self.accessToken = accessToken
    }
    
    // MARK: - Alamofire.RequestInterceptor
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void) {

        guard let url = urlRequest.url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = urlRequest
        request.url = appendingBaseURL(to: url)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        completion(.success(request))
    }
    
    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void) {
        
        return completion(.doNotRetryWithError(error))
    }
    
    // MARK: - Private methods
    
    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }
}
