//
//  PublishPostEndpointTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import WorkplacesAPI
import XCTest

final class PublishPostEndpointTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let author = User(
        id: "test",
        firstName: "test",
        lastName: "test",
        nickname: "test",
        avatarURL: URL(string: "https://redmadrobot.com/")!,
        birthday: Date()
    )
    private lazy var post = Post(
        id: "test",
        text: "test",
        imageURL: URL(string: "https://redmadrobot.com/")!,
        longitude: 0,
        latitude: 0,
        author: author,
        likes: 0,
        liked: true
    )
    
    // MARK: - Public methods
    
    func testMakeRequest() throws {
        let endpoint = PublishPostEndpoint(post: post)
        let urlRequest = try endpoint.makeRequest()
        
        assertPOST(urlRequest)
        assertURL(urlRequest, "me/posts")
        // Нужно ещё проверить body
    }
    
    func testContentDecoding() throws {
        let jsonData = """
            {
                "id": "8feed535-5ca5-464e-862d-0de124800aa3",
                "text": "Hello world!",
                "image_url": "https://redmadrobot.com/",
                "lon": 5.324854,
                "lat": 60.39136,
                "author": {
                    "id": "8feed535-5ca5-464e-862d-0de124800aa3",
                    "first_name": "Martin",
                    "last_name": "Fowler",
                    "nickname": "RefactorMan",
                    "avatar_url": "https://redmadrobot.com/",
                    "birth_day": "2021-12-21"
                },
                "likes": 321,
                "liked": true
            }
        """.data(using: .utf8)!
        
        let endpoint = PublishPostEndpoint(post: post)
        let post = try endpoint.content(from: nil, with: jsonData)
        
        XCTAssertEqual(post.id, "8feed535-5ca5-464e-862d-0de124800aa3", "Error \"id\" decoding")
        XCTAssertEqual(post.text, "Hello world!", "Error \"text\" decoding")
        XCTAssertEqual(post.imageURL, URL(string: "https://redmadrobot.com/"), "Error \"imageURL\" decoding")
        XCTAssertEqual(post.longitude, 5.324854, "Error \"longitude\" decoding")
        XCTAssertEqual(post.latitude, 60.39136, "Error \"latitude\" decoding")
        XCTAssertNotNil(post.author, "Error \"author\" decoding")
        XCTAssertEqual(post.likes, 321, "Error \"likes\" decoding")
        XCTAssertEqual(post.liked, true, "Error \"liked\" decoding")
    }
}
