//
//  ClientMock.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 07.05.2021.
//

import Apexy

final class ClientMock<T: Endpoint>: Client {
    
    var result: Result<T.Content, Error>?
    
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (APIResult<T.Content>) -> Void
    ) -> Progress where T: Endpoint {
        switch result {
        case let .success(content):
            if let content = content as? T.Content {
                completionHandler(.success(content))
            }
        case let .failure(error):
            completionHandler(.failure(error))
        case .none:
            break
        }
        return Progress()
    }
    
    func upload<T>(
        _ endpoint: T,
        completionHandler: @escaping (APIResult<T.Content>) -> Void
    ) -> Progress where T: UploadEndpoint {
        switch result {
        case let .success(content):
            if let content = content as? T.Content {
                completionHandler(.success(content))
            }
        case let .failure(error):
            completionHandler(.failure(error))
        case .none:
            break
        }
        return Progress()
    }
}
