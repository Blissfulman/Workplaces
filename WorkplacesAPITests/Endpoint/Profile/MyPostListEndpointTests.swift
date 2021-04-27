//
//  MyPostListEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class MyPostListEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let endpoint = MyPostListEndpoint()
        let urlRequest = try endpoint.makeRequest()
        
        assertGET(urlRequest)
        assertURL(urlRequest, "me/posts")
    }
}
