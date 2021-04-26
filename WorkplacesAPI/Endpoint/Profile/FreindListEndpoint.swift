//
//  FreindListEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct FreindListEndpoint: JsonEndpoint {
    
    public typealias Content = [User]
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        get(URL(string: "me/friends")!)
    }
}
