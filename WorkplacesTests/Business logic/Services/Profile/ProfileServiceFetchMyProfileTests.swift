//
//  ProfileServiceFetchMyProfileTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 08.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class ProfileServiceFetchMyProfileTests: XCTestCase {
    
    private let client = ClientMock<MyProfileEndpoint>()
    private var profileService: ProfileService?
    let profile = User(
        id: "test",
        firstName: "test",
        lastName: "test",
        nickname: "test",
        avatarURL: URL(string: "https://redmadrobot.com/")!,
        birthday: Date()
    )
    
    override func setUp() {
        super.setUp()
        profileService = ProfileServiceImpl(apiClient: client)
    }
    
    func testPublishPostSuccess() {
        client.result = .success(profile)
        
        profileService?.fetchMyProfile { result in
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
        
        profileService?.fetchMyProfile { result in
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
