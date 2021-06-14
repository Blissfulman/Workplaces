//
//  NewPostServicePublishPostTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class NewPostServicePublishPostTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let client = ClientMock<PublishPostEndpoint>()
    private var newPostService: NewPostService?
    private let uploadPost = UploadPost(
        text: "test",
        imageFileURL: nil,
        location: UploadPost.Location(longitude: 0, latitude: 0)
    )
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
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        newPostService = NewPostServiceImpl(apiClient: client)
    }
    
    // MARK: - Public methods
    
    func testPublishPostSuccess() {
        client.result = .success(post)
        
        newPostService?.publishPost(uploadPost: uploadPost) { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testPublishPostFailure() {
        let expectedError = APIError(code: .genericError, message: "")
        client.result = .failure(expectedError)
        
        newPostService?.publishPost(uploadPost: uploadPost) { result in
            var boolResult = false
            if case let .failure(error) = result,
               let apiError = error as? APIError,
               apiError.code == expectedError.code {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
}
