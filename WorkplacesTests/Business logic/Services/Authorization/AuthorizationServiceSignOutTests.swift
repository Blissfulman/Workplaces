//
//  AuthorizationServiceSignOutTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 07.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class AuthorizationServiceSignOutTests: XCTestCase {
    
    private let client = ClientMock<LogoutEndpoint>()
    private var authorizationService: AuthorizationService?
    private var authDataStorage = AuthDataStorageMock(storage: UserDefaults(suiteName: "Test UserDefaults")!)
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
        client.result = .success(())
        
        authorizationService?.signOut { result in
            var boolResult = false
            if case .success = result {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testSignUpFailure() {
        let expectedError = APIError(code: .genericError, message: "")
        client.result = .failure(expectedError)
        
        authorizationService?.signOut { result in
            var boolResult = false
            if case let .failure(error) = result,
               let apiError = error as? APIError,
               apiError.code == expectedError.code {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testTokenShouldBeRemovedWhenSignOutSuccessful() {
        authDataStorage.saveAuthData(authorizationData)
        client.result = .success(())
        
        authorizationService?.signOut { [weak self] _ in
            XCTAssertNil(self?.authDataStorage.accessToken)
            XCTAssertNil(self?.authDataStorage.refreshToken)
        }
    }
    
    func testTokenShouldNotBeRemovedWhenSignOutFailed() {
        authDataStorage.saveAuthData(authorizationData)
        let error = APIError(code: .genericError, message: "")
        client.result = .failure(error)
                
        authorizationService?.signOut { [weak self] _ in
            XCTAssertNotNil(self?.authDataStorage.accessToken)
            XCTAssertNotNil(self?.authDataStorage.refreshToken)
        }
    }
}
