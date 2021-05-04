//
//  EmptyEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

protocol EmptyEndpoint: Endpoint, URLRequestBuildable where Content == Void {}

extension EmptyEndpoint {
    
    var encoder: JSONEncoder { JSONEncoder.default }
    
    public func validate(_ request: URLRequest?, response: HTTPURLResponse, data: Data?) throws {
        try ResponseValidator.validate(response, with: data ?? Data())
    }
    
    public func content(from response: URLResponse?, with body: Data) throws {}
}
