//
//  AuthRequestInterceptor.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire

public final class AuthRequestInterceptor: RequestInterceptor {
    
    // MARK: - Typealiases
    
    typealias RetryCompletion = (RetryResult) -> Void
    
    // MARK: - Nested types

    struct RetryCompletionStorage {
        
        var isInProgressRefreshingToken = false
        var progressLock = NSLock()
        var completions = [RetryCompletion]()
        let completionsLock = NSLock()
        
        func getProgressState() -> Bool {
            progressLock.lock()
            let result = isInProgressRefreshingToken
            progressLock.unlock()
            return result
        }
        
        mutating func switchProgress(to state: Bool) {
            progressLock.lock()
            isInProgressRefreshingToken = state
            progressLock.unlock()
        }
        
        mutating func add(completion: @escaping RetryCompletion) {
            completionsLock.lock()
            completions.append(completion)
            completionsLock.unlock()
        }
        
        mutating func getCompletions() -> [RetryCompletion] {
            completionsLock.lock()
            let result = completions
            completions = []
            completionsLock.unlock()
            return result
        }
    }
    
    // MARK: - Private properties
    
    private let baseURL: URL
    private let authDataStorage: AuthDataStorage
    private let tokenRefreshService: () -> TokenRefreshService
    private var retryCompletionStorage = RetryCompletionStorage()
    
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
        guard checkTheNeedToRetry(byError: error) else { return completion(.doNotRetry) }
        
        print(request.retryCount, "Description:", request.description)
        
        retryCompletionStorage.add(completion: completion)
        tryToRefreshToken()
    }
    
    // MARK: - Private methods
    
    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }
    
    /// Проверка необходимости повторной попытки запроса, основываясь на ошибке.
    /// - Parameter error: Ошибка.
    /// - Returns: Возвращает `true`, если необходим повторный запрос, в обратном случае возвращает `false`.
    private func checkTheNeedToRetry(byError error: Error) -> Bool {
        print(type(of: error.unwrapAFError().unwrapAFError()))
        print(error)
        if let urlError = error.unwrapAFError() as? URLError {
            print("URLError:", urlError.localizedDescription)
            return true
        }
        
        if let afError = error.unwrapAFError() as? AFError {
            print("AFError:", afError.localizedDescription)
            return true
        }
        
        if let httpError = error.unwrapAFError() as? HTTPError, (300..<600).contains(httpError.statusCode) {
            print("HTTPError, code \(httpError.statusCode):", error.localizedDescription)
            return true
        }
        print("Don't need retry. Error:", error.localizedDescription)
        return false
    }
    
    private func tryToRefreshToken() {
        guard !retryCompletionStorage.getProgressState() else { return }
        
        retryCompletionStorage.switchProgress(to: true)
        tokenRefreshService().refreshToken { [weak self] result in
            self?.retryCompletionStorage.switchProgress(to: false)
            
            switch result {
            case .success:
                self?.retryCompletionStorage.getCompletions().forEach {
                    $0(.retry)
                }
            case .failure:
                self?.retryCompletionStorage.getCompletions().forEach {
                    $0(.doNotRetry)
                }
            }
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
