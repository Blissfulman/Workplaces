//
//  LikedPostListEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class LikedPostListEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let endpoint = LikedPostListEndpoint()
        let urlRequest = try endpoint.makeRequest()
        
        assertGET(urlRequest)
        assertURL(urlRequest, "feed/favorite")
    }
}
