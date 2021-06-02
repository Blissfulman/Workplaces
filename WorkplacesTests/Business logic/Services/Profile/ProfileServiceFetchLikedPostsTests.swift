//
//  ProfileServiceFetchLikedPostsTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class ProfileServiceFetchLikedPostsTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let client = ClientMock<LikedPostListEndpoint>()
    private var profileService: ProfileService?
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        profileService = ProfileServiceImpl(apiClient: client)
    }
    
    // MARK: - Public methods
    
    func testPublishPostSuccess() {
        client.result = .success(([]))
        
        profileService?.fetchLikedPosts { result in
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
        
        profileService?.fetchLikedPosts { result in
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
