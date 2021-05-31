//
//  RetryManager.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 31.05.2021.
//

import Alamofire

public protocol RetryManager {
    func handle(request: Request, error: Error, completion: @escaping (RetryResult) -> Void)
}
