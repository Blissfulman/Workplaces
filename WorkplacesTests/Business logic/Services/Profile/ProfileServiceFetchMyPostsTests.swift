//
//  ProfileServiceFetchMyPostsTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class ProfileServiceFetchMyPostsTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let client = ClientMock<MyPostListEndpoint>()
    private var profileService: ProfileService?
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        profileService = ProfileServiceImpl(apiClient: client)
    }
    
    // MARK: - Public methods
    
    func testPublishPostSuccess() {
        client.result = .success(([]))
        
        profileService?.fetchMyPosts { result in
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
        
        profileService?.fetchMyPosts { result in
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
