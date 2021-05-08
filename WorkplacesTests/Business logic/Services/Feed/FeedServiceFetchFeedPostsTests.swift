//
//  FeedServiceFetchFeedPostsTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class FeedServiceFetchFeedPostsTests: XCTestCase {
    
    private let client = ClientMock<FeedPostListEndpoint>()
    private var feedService: FeedService?
    
    override func setUp() {
        super.setUp()
        feedService = FeedServiceImpl(apiClient: client)
    }
    
    func testFetchFeedPostsSuccess() {
        client.result = .success(([]))
        
        feedService?.fetchFeedPosts { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testFetchFeedPostsFailure() {
        let expectedError = APIError(code: .genericError, message: "")
        client.result = .failure(expectedError)
        
        feedService?.fetchFeedPosts { result in
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
