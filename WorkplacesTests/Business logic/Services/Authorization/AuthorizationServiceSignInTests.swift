//
//  AuthorizationServiceSignInTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//
/*
@testable import Workplaces
import WorkplacesAPI
import XCTest

final class AuthorizationServiceSignInTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let client = ClientMock<LoginEndpoint>()
    private var authorizationService: AuthorizationService?
    private var tokenStorage = TokenStorageMock(storage: UserDefaults(suiteName: "Test UserDefaults")!)
    private let userCredentials = UserCredentials(email: "test", password: "test")
    private let authorizationData = AuthorizationData(accessToken: "test", refreshToken: "test")
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        authorizationService = AuthorizationServiceImpl(apiClient: client, tokenStorage: tokenStorage)
    }
    
    override func tearDown() {
        deleteTokens()
        super.tearDown()
    }
    
    // MARK: - Public methods
    
    func testSignInSuccess() {
        client.result = .success(authorizationData)
        
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
               let authError = error as? AuthorizationServiceError,
               authError == .passwordValidationError {
                boolResult = true
            }
            XCTAssertTrue(boolResult)
        }
    }
    
    func testTokenShouldBeSavedWhenSignInSuccessful() {
        deleteTokens()
        client.result = .success(authorizationData)
        
        authorizationService?.signInWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNotNil(self?.tokenStorage.refreshToken)
            XCTAssertNotNil(self?.tokenStorage.accessToken)
        }
    }
    
    func testTokenShouldNotBeSavedWhenSignInFailed() {
        deleteTokens()
        let error = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(error)
        
        authorizationService?.signInWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNil(self?.tokenStorage.temporaryRefreshToken)
            XCTAssertNil(self?.tokenStorage.accessToken)
        }
    }
    
    // MARK: - Private methods
    
    private func deleteTokens() {
        tokenStorage.temporaryRefreshToken = nil
        tokenStorage.accessToken = nil
    }
}
*/
