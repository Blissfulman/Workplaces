//
//  RetryRequestManagerImpl.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 31.05.2021.
//

import Alamofire

// MARK: - Protocols

public protocol RetryRequestManager {
    /// Обработка запроса на необходимость выполнения повторных запросов на основании вернувшейся в ответе ошибки.
    ///
    /// Также в этом методе при необходимости инициируется процесс обновления токена.
    /// - Parameters:
    ///   - request: Запрос `Request`.
    ///   - error: Ошибка, вернувшаяся в ответе запроса.
    ///   - completion: Замыкание, вызываемое для осуществления повторной попытки запроса.
    func handle(_ request: Request, dueTo error: Error, completion: @escaping (RetryResult) -> Void)
}

public final class RetryRequestManagerImpl: RetryRequestManager {
    
    // MARK: - Private properties
    
    private let tokenRefreshService: () -> TokenRefreshService
    private var retryCompletionStorage: RetryCompletionStorage
    private let retryDelays: [TimeInterval]
    
    // MARK: - Initializers
    
    /// Создаёт экземпляр `RetryRequestManagerImpl`.
    ///
    /// Количество элементов, переданное в параметр `retryDelays`, будет определять общее количество повторных запросов.
    /// - Parameters:
    ///   - tokenRefreshService: Передаваемый по ссылке сервис обновления токена `TokenRefreshService`.
    ///   - retryCompletionStorage: Хранилище комплишенов для повторных запросов `RetryCompletionStorage`.
    ///   - retryDelays: Массив временных интервалов между повторными запросами.
    public init(
        tokenRefreshService: @escaping () -> TokenRefreshService,
        retryCompletionStorage: RetryCompletionStorage,
        retryDelays: [TimeInterval] = APIConstants.retryDelays
    ) {
        self.tokenRefreshService = tokenRefreshService
        self.retryCompletionStorage = retryCompletionStorage
        self.retryDelays = retryDelays
    }
    
    // MARK: - Public methods
    
    public func handle(_ request: Request, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let error = error.unwrapAFError() as? HTTPError, error.statusCode == 401 {
            retryCompletionStorage.add(completion: completion)
            tryToRefreshToken()
        } else {
            guard checkTheNeedToRetry(forError: error) else { return completion(.doNotRetry) }
            print(request.retryCount, "Description:", request.description) // TEMP
            print(Date(timeIntervalSinceNow: 0)) // TEMP
            
            request.retryCount < retryDelays.count
                ? completion(.retryWithDelay(retryDelays[request.retryCount]))
                : completion(.doNotRetry)
        }
    }
    
    // MARK: - Private methods
    
    private func tryToRefreshToken() {
        guard !retryCompletionStorage.getProgressState() else { return }

        retryCompletionStorage.switchProgress(to: true)
        tokenRefreshService().refreshToken { [weak self] result in
            self?.retryCompletionStorage.switchProgress(to: false)

            switch result {
            case .success:
                print("Token refresh successfully") // TEMP
                self?.retryCompletionStorage.extractCompletions().forEach { $0(.retry) }
            case .failure:
                print("Token refresh error") // TEMP
                self?.retryCompletionStorage.extractCompletions().forEach { $0(.doNotRetry) }
            }
        }
    }
    
    /// Проверка необходимости повторной попытки запроса, основываясь на ошибке.
    /// - Parameter error: Ошибка.
    /// - Returns: Возвращает `true`, если необходим повторный запрос, в обратном случае возвращает `false`.
    private func checkTheNeedToRetry(forError error: Error) -> Bool {
        if let afError = error.unwrapAFError() as? AFError,
           afError.underlyingError is URLError { return true }
        if let httpError = error.unwrapAFError() as? HTTPError,
           (300..<600).contains(httpError.statusCode) { return true }
        return false
    }
}
