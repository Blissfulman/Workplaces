//
//  FeedServiceUnlikePostTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class FeedServiceUnlikePostTests: XCTestCase {
    
    private let client = ClientMock<UnlikePostEndpoint>()
    private var feedService: FeedService?
    
    override func setUp() {
        super.setUp()
        feedService = FeedServiceImpl(apiClient: client)
    }
    
    func testUnlikePostSuccess() {
        client.result = .success(())
        
        feedService?.unlikePost(postID: "test") { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testUnlikePostFailure() {
        let expectedError = APIError(code: .genericError, message: "")
        client.result = .failure(expectedError)
        
        feedService?.unlikePost(postID: "test") { result in
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
