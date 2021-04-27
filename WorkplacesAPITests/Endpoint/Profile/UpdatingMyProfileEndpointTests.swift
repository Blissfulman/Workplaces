//
//  UpdatingMyProfileEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class UpdatingMyProfileEndpointTests: XCTestCase {

    func testMakeRequest() throws {
        let user = User.testUser()
        let endpoint = UpdatingMyProfileEndpoint(user: user)
        let urlRequest = try endpoint.makeRequest()
        
        assertPATCH(urlRequest)
        assertURL(urlRequest, "me")
        // Нужно ещё проверить body
    }
}
