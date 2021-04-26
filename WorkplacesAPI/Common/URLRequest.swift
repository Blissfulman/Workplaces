//
//  URLRequest.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

extension URLRequest {
    
    func addAccessToken() -> URLRequest {
        let token = ""
        var request = self
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
