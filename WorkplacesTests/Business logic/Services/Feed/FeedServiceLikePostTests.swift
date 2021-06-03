//
//  FeedServiceLikePostTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class FeedServiceLikePostTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let client = ClientMock<LikePostEndpoint>()
    private var feedService: FeedService?
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        feedService = FeedServiceImpl(apiClient: client)
    }
    
    // MARK: - Public methods
    
    func testLikePostSuccess() {
        client.result = .success(())
        
        feedService?.likePost(postID: "test") { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testLikePostFailure() {
        let expectedError = APIError(code: .genericError, message: "")
        client.result = .failure(expectedError)
        
        feedService?.likePost(postID: "test") { result in
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
