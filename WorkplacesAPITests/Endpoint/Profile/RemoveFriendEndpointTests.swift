//
//  RemoveFriendEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class RemoveFriendEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let userID: User.ID = "test"
        let endpoint = RemoveFriendEndpoint(userID: userID)
        let urlRequest = try endpoint.makeRequest()
        
        assertDELETE(urlRequest)
        assertURL(urlRequest, "me/friends/\(userID)")
    }
}
