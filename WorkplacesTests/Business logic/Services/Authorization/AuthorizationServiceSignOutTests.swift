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
    
    // MARK: - Private properties
    
    private let client = ClientMock<LogoutEndpoint>()
    private var authorizationService: AuthorizationService?
    private var tokenStorage = TokenStorageMock(storage: UserDefaults(suiteName: "Test UserDefaults")!)
    private let authorizationData = AuthorizationData(accessToken: "test", refreshToken: "test")
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        authorizationService = AuthorizationServiceImpl(apiClient: client, tokenStorage: tokenStorage)
    }

    override func tearDown() {
        tokenStorage.refreshToken = nil
        tokenStorage.accessToken = nil
        super.tearDown()
    }
    
    // MARK: - Public methods
    
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
        tokenStorage.refreshToken = authorizationData.refreshToken
        tokenStorage.accessToken = authorizationData.accessToken
        client.result = .success(())
        
        authorizationService?.signOut { [weak self] _ in
            XCTAssertNil(self?.tokenStorage.accessToken)
            XCTAssertNil(self?.tokenStorage.refreshToken)
        }
    }
    
    func testTokenShouldNotBeRemovedWhenSignOutFailed() {
        tokenStorage.refreshToken = authorizationData.refreshToken
        tokenStorage.accessToken = authorizationData.accessToken
        let error = APIError(code: .genericError, message: "")
        client.result = .failure(error)
                
        authorizationService?.signOut { [weak self] _ in
            XCTAssertNotNil(self?.tokenStorage.accessToken)
            XCTAssertNotNil(self?.tokenStorage.refreshToken)
        }
    }
}
