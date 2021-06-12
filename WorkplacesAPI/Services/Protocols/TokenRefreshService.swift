//
//  RefreshingTokenService.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.05.2021.
//

public protocol TokenRefreshService {
    
    typealias ResultHandler<T> = (Result<T, Error>) -> Void
    
    /// Обновление токенов.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func refreshTokens(completion: @escaping ResultHandler<AuthorizationData>) -> Progress
}
