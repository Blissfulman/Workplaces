//
//  AuthorizationServiceSignUpTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 07.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class AuthorizationServiceSignUpTests: XCTestCase {
    
    private let client = ClientMock<RegistrationEndpoint>()
    private var authorizationService: AuthorizationService?
    private var authDataStorage = AuthDataStorageMock(storage: UserDefaults(suiteName: "Test UserDefaults")!)
    private let userCredentials = UserCredentials(email: "test", password: "test")
    private let authorizationData = AuthorizationData(accessToken: "test", refreshToken: "test")
    
    override func setUp() {
        super.setUp()
        authorizationService = AuthorizationServiceImpl(apiClient: client, authDataStorage: authDataStorage)
    }

    override func tearDown() {
        authDataStorage.deleteAuthData()
        super.tearDown()
    }
    
    func testSignUpSuccess() {
        client.result = .success(authorizationData)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testSignUpFailure() {
        let expectedError = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(expectedError)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { result in
            var boolResult = false
            if case let .failure(error) = result,
               let apiError = error as? APIError,
               apiError.code == expectedError.code {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testTokenShouldBeSavedWhenSignUpSuccessful() {
        authDataStorage.deleteAuthData()
        client.result = .success(authorizationData)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNotNil(self?.authDataStorage.accessToken)
            XCTAssertNotNil(self?.authDataStorage.refreshToken)
        }
    }
    
    func testTokenShouldNotBeSavedWhenSignUpFailed() {
        authDataStorage.deleteAuthData()
        let error = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(error)
                
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNil(self?.authDataStorage.accessToken)
            XCTAssertNil(self?.authDataStorage.refreshToken)
        }
    }
}