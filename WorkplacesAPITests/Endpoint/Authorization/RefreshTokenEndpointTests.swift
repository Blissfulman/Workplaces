//
//  RefreshTokenEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class RefreshTokenEndpointTests: XCTestCase {
    
    func testMakeRequest() throws {
        let refreshToken = "test"
        let endpoint = RefreshTokenEndpoint(refreshToken: refreshToken)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "auth/refresh")
        assertJsonBody(urlRequest, ["token": refreshToken])
    }
}
