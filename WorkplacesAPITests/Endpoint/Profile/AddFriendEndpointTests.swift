//
//  AddFriendEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class AddFriendEndpointTests: XCTestCase {
    
    func testMakeRequest() throws {
        let userID: User.ID = "test"
        let endpoint = AddFriendEndpoint(userID: userID)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "me/friends")
        assertJsonBody(urlRequest, ["user_id": userID])
    }
}
