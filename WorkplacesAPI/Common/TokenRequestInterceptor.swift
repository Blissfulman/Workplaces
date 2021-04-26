//
//  TokenRequestInterceptor.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire
import Apexy

public final class TokenRequestInterceptor: BaseRequestInterceptor {
    
    private let accessToken: String
    
    public init(baseURL: URL, accessToken: String) {
        self.accessToken = accessToken
        super.init(baseURL: baseURL)
    }
    
    public override func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var requestWithToken = urlRequest
        requestWithToken.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        super.adapt(requestWithToken, for: session, completion: completion)
    }
}
