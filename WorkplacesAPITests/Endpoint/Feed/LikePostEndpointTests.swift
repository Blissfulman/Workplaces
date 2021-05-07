//
//  LikePostEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class LikePostEndpointTests: XCTestCase {
    
    func testMakeRequest() throws {
        let postID: Post.ID = "test"
        let endpoint = LikePostEndpoint(postID: postID)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "feed/\(postID)/like")
    }
}
