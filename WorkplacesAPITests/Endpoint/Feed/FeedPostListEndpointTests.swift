//
//  FeedPostListEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class FeedPostListEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let endpoint = FeedPostListEndpoint()
        let urlRequest = try endpoint.makeRequest()
        
        assertGET(urlRequest)
        assertURL(urlRequest, "feed")
    }
}
