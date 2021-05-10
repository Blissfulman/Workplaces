//
//  ProfileServiceRemoveFriendTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class ProfileServiceRemoveFriendTests: XCTestCase {
    
    private let client = ClientMock<RemoveFriendEndpoint>()
    private var profileService: ProfileService?
    
    override func setUp() {
        super.setUp()
        profileService = ProfileServiceImpl(apiClient: client)
    }
    
    func testPublishPostSuccess() {
        client.result = .success(())
        
        profileService?.removeFriend(userID: "test") { result in
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
        
        profileService?.removeFriend(userID: "test") { result in
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