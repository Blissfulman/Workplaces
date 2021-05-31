//
//  RetryManager.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 31.05.2021.
//

import Alamofire

final class RetryManager {
    
    // MARK: - Private properties
    
    private let retryDelays: [Int: TimeInterval] = [0: 1, 1: 2, 2: 4, 3: 10, 4: 15]
    
    // MARK: - Public methods
    
    func handle(request: Request, error: Error, completion: @escaping (RetryResult) -> Void) {
        guard checkTheNeedToRetry(byError: error) else { return completion(.doNotRetry) }
        print(request.retryCount, "Description:", request.description)
        print(Date(timeIntervalSinceNow: 0))
        
        request.retryCount < 5
            ? completion(.retryWithDelay(retryDelays[request.retryCount] ?? 20))
            : completion(.doNotRetry)
    }
    
    // MARK: - Private methods
    
    /// Проверка необходимости повторной попытки запроса, основываясь на ошибке.
    /// - Parameter error: Ошибка.
    /// - Returns: Возвращает `true`, если необходим повторный запрос, в обратном случае возвращает `false`.
    private func checkTheNeedToRetry(byError error: Error) -> Bool {
        if let afError = error.unwrapAFError() as? AFError,
           let urlError = afError.underlyingError as? URLError {
            print("URLError:", urlError.localizedDescription)
            return true
        }
        if let httpError = error.unwrapAFError() as? HTTPError, (300..<600).contains(httpError.statusCode) {
            print("HTTPError, code \(httpError.statusCode):", error.localizedDescription)
            return true
        }
        return false
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
