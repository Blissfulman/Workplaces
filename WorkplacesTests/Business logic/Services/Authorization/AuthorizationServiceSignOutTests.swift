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
    private var securityManager = SecurityManagerFake()
    private let authorizationData = AuthorizationData(accessToken: "test", refreshToken: "test")
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        authorizationService = AuthorizationServiceImpl(apiClient: client, securityManager: securityManager)
    }
    
    override func tearDown() {
        securityManager.logoutReset()
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
    
    func testTokensShouldBeRemovedWhenSignOutSuccessful() {
        securityManager.refreshToken = authorizationData.refreshToken
        securityManager.accessToken = authorizationData.accessToken
        client.result = .success(())
        
        authorizationService?.signOut { _ in }
        XCTAssertNil(securityManager.refreshToken)
        XCTAssertNil(securityManager.accessToken)
    }
    
    func testTokensShouldBeRemovedWhenSignOutFailed() {
        securityManager.refreshToken = authorizationData.refreshToken
        securityManager.accessToken = authorizationData.accessToken
        let error = APIError(code: .genericError, message: "")
        client.result = .failure(error)
        
        authorizationService?.signOut { _ in }
        XCTAssertNil(securityManager.refreshToken)
        XCTAssertNil(securityManager.accessToken)
    }
    
    func testIsAuthorizedShouldBeFalseWhenSignOutSuccessful() {
        securityManager.isAuthorized = true
        client.result = .success(())
        
        authorizationService?.signOut { _ in }
        XCTAssertFalse(self.securityManager.isAuthorized)
    }
    
    func testIsAuthorizedShouldBeFalseWhenSignOutFailed() {
        securityManager.isAuthorized = true
        let error = APIError(code: .genericError, message: "")
        client.result = .failure(error)
        
        authorizationService?.signOut { _ in }
        XCTAssertFalse(self.securityManager.isAuthorized)
    }
}
