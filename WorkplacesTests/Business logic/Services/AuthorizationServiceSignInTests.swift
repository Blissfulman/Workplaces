//
//  AuthorizationServiceSignInTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class AuthorizationServiceSignInTests: XCTestCase {
    
    private let client = ClientMock<LoginEndpoint>()
    private var authorizationService: AuthorizationService?
    private var authDataStorage = AuthDataStorageMock(storage: UserDefaults(suiteName: "Test UserDefaults")!)
    private let userCredentials = UserCredentials(email: "test", password: "test")
    
    override func setUp() {
        super.setUp()
        authorizationService = AuthorizationServiceImpl(apiClient: client, authDataStorage: authDataStorage)
    }

    override func tearDown() {
        authDataStorage.deleteAuthData()
        super.tearDown()
    }
    
    func testSignInSuccess() {
        client.result = .success(AuthorizationData.testAuthorizationData())
        
        authorizationService?.signInWithEmail(userCredentials: userCredentials) { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testSignInFailure() {
        let expectedError = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(expectedError)
        
        authorizationService?.signInWithEmail(userCredentials: userCredentials) { result in
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
