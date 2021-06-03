//
//  SearchPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 17.05.2021.
//

import Apexy

public struct SearchPostEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = [Post]
    
    // MARK: - Private properties
    
    private let query: String
    
    // MARK: - Initializers
    
    public init(query: String) {
        self.query = query
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: "search")!
        urlComponents.queryItems = [URLQueryItem(name: "post", value: query)]
        return get(urlComponents.url!)
    }
}
