//
//  SearchPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import Apexy

public struct SearchPostEndpoint: JsonEndpoint {
    
    public typealias Content = [Post]
    
    private let query: String
    
    public init(query: String) {
        self.query = query
    }
    
    public func makeRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: "search")!
        urlComponents.queryItems = [URLQueryItem(name: "post", value: query)]
        return get(urlComponents.url!)
    }
}
