//
//  LogoutEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class LogoutEndpointTests: XCTestCase {
    
    func testMakeRequest() throws {
        let endpoint = LogoutEndpoint()
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "auth/logout")
    }
}
