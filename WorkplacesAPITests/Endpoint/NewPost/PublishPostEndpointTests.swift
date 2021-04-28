//
//  PublishPostEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class PublishPostEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let post = Post.testPost()
        let endpoint = PublishPostEndpoint(post: post)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "me/posts")
        // Нужно ещё проверить body
    }
}
