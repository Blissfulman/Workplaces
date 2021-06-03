//
//  UpdateMyProfileEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 27.04.2021.
//

import WorkplacesAPI
import XCTest

final class UpdateMyProfileEndpointTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let user = User(
        id: "test",
        firstName: "test",
        lastName: "test",
        nickname: "test",
        avatarURL: URL(string: "https://redmadrobot.com/")!,
        birthday: Date()
    )
    
    func testMakeRequest() throws {
        let endpoint = UpdateMyProfileEndpoint(user: user)
        let urlRequest = try endpoint.makeRequest()
        
        assertPATCH(urlRequest)
        assertURL(urlRequest, "me")
        // Нужно ещё проверить body
    }
    
    // MARK: - Public methods
    
    func testContentDecoding() throws {
        let jsonData = """
            {
                "id": "8feed535-5ca5-464e-862d-0de124800aa3",
                "first_name": "Martin",
                "last_name": "Fowler",
                "nickname": "RefactorMan",
                "avatar_url": "https://redmadrobot.com/",
                "birth_day": "2021-12-21"
            }
        """.data(using: .utf8)!
        
        let endpoint = UpdateMyProfileEndpoint(user: user)
        let user = try endpoint.content(from: nil, with: jsonData)
        
        XCTAssertEqual(user.id, "8feed535-5ca5-464e-862d-0de124800aa3", "Error \"id\" decoding")
        XCTAssertEqual(user.firstName, "Martin", "Error \"firstName\" decoding")
        XCTAssertEqual(user.lastName, "Fowler", "Error \"lastName\" decoding")
        XCTAssertEqual(user.nickname, "RefactorMan", "Error \"nickname\" decoding")
        XCTAssertEqual(user.avatarURL, URL(string: "https://redmadrobot.com/"), "Error \"avatarURL\" decoding")
        XCTAssertEqual(user.birthday, Date.makeDate(year: 2021, month: 12, day: 21), "Error \"birthday\" decoding")
    }
}
