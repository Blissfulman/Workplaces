//
//  UnlikePostEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class UnlikePostEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let postID: Post.ID = "test"
        let endpoint = UnlikePostEndpoint(postID: postID)
        let urlRequest = try endpoint.makeRequest()
        
        assertDELETE(urlRequest)
        assertURL(urlRequest, "feed/\(postID)/like")
    }
}
