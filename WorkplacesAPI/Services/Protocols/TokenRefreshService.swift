//
//  RefreshingTokenService.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.05.2021.
//

public typealias ResultHandler<T> = (Result<T, Error>) -> Void
public typealias AuthorizationDataResultHandler = ResultHandler<AuthorizationData>

public protocol TokenRefreshService {
    
    /// Обновление токена доступа.
    /// - Parameter completion: Обработчик завершения, в который возвращается результат запроса.
    @discardableResult
    func refreshToken(completion: @escaping AuthorizationDataResultHandler) -> Progress
}
