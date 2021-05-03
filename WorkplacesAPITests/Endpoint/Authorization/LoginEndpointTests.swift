//
//  LoginEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class LoginEndpointTests: XCTestCase {
    
    func testMakeRequest() throws {
        let userCredentials = UserCredentials(email: "email", password: "password")
        let endpoint = LoginEndpoint(userCredentials: userCredentials)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "auth/login")
        assertJsonBody(urlRequest, ["email": "email", "password": "password"])
    }
}
