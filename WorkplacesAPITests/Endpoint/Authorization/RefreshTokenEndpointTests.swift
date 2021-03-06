//
//  RefreshTokenEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class RefreshTokenEndpointTests: XCTestCase {
    
    // MARK: - Public methods
    
    func testMakeRequest() throws {
        let refreshToken = "test"
        let endpoint = RefreshTokenEndpoint(refreshToken: refreshToken)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "auth/refresh")
        assertJsonBody(urlRequest, ["token": refreshToken])
    }
    
    func testContentDecoding() throws {
        let jsonData = """
            {
                "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM",
                "refresh_token": "8feed535-5ca5-464e-862d-0de124800aa3"
            }
        """.data(using: .utf8)!
        
        let endpoint = RefreshTokenEndpoint(refreshToken: "test")
        
        XCTAssertNotNil(try endpoint.content(from: nil, with: jsonData), "Error decoding")
        
        let authorizationData = try endpoint.content(from: nil, with: jsonData)
        
        XCTAssertEqual(
            authorizationData.accessToken,
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM",
            "Error access token decoding"
        )
        XCTAssertEqual(
            authorizationData.refreshToken,
            "8feed535-5ca5-464e-862d-0de124800aa3",
            "Error refresh token decoding"
        )
    }
}
