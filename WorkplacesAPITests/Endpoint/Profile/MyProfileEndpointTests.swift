//
//  MyProfileEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class MyProfileEndpointTests: XCTestCase {
    
    func testMakeRequest() throws {
        let endpoint = MyProfileEndpoint()
        let urlRequest = try endpoint.makeRequest()
        
        assertGET(urlRequest)
        assertURL(urlRequest, "me")
    }
}
