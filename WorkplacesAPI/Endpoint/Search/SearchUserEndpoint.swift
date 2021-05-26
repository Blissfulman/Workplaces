//
//  SearchUserEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import Apexy

public struct SearchUserEndpoint: JsonEndpoint {
    
    public typealias Content = [User]
    
    private let query: String
    
    public init(query: String) {
        self.query = query
    }
    
    public func makeRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: "search")!
        urlComponents.queryItems = [URLQueryItem(name: "user", value: query)]
        return get(urlComponents.url!)
    }
}
