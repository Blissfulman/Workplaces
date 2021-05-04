//
//  JsonEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

protocol JsonEndpoint: Endpoint, URLRequestBuildable where Content: Decodable {}

extension JsonEndpoint {

    var encoder: JSONEncoder { JSONEncoder.default }
    
    public func validate(_ request: URLRequest?, response: HTTPURLResponse, data: Data?) throws {
        try ResponseValidator.validate(response, with: data ?? Data())
    }

    public func content(from response: URLResponse?, with body: Data) throws -> Content {
        try JSONDecoder.default.decode(Content.self, from: body)
    }
}
