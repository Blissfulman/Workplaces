//
//  LikedPostListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct LikedPostListEndpoint: JsonEndpoint {
    
    public typealias Content = [Post]
    private let token = ""
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        var request = get(URL(string: "feed/favorite")!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
