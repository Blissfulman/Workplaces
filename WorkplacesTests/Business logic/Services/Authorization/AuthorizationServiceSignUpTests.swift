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
    
    // MARK: - Private properties
    
    private let client = ClientMock<RegistrationEndpoint>()
    private var authorizationService: AuthorizationService?
    private var securityManager = SecurityManagerFake()
    private let userCredentials = UserCredentials(email: "test", password: "test")
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
               let authError = error as? AuthorizationServiceError,
               authError == .passwordValidationError {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testTokensShouldBeSavedWhenSignUpSuccessful() {
        securityManager.logoutReset()
        client.result = .success(authorizationData)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNotNil(self?.securityManager.refreshToken)
            XCTAssertNotNil(self?.securityManager.accessToken)
        }
    }
    
    func testTokensShouldNotBeSavedWhenSignUpFailed() {
        securityManager.logoutReset()
        let error = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(error)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNil(self?.securityManager.refreshToken)
            XCTAssertNil(self?.securityManager.accessToken)
        }
    }
    
    func testIsAuthorizedShouldBeTrueWhenSignUpSuccessful() {
        securityManager.isAuthorized = false
        client.result = .success(authorizationData)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            guard let self = self else { return XCTAssert(false) }
            XCTAssertTrue(self.securityManager.isAuthorized)
        }
    }
    
    func testIsAuthorizedShouldBeFalseWhenSignUpFailed() {
        securityManager.isAuthorized = false
        let error = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(error)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            guard let self = self else { return XCTAssert(false) }
            XCTAssertFalse(self.securityManager.isAuthorized)
        }
    }
}
