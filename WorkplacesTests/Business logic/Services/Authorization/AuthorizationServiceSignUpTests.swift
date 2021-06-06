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
    
    func testTokenShouldBeSavedWhenSignUpSuccessful() {
        deleteTokens()
        client.result = .success(authorizationData)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNotNil(self?.tokenStorage.temporaryRefreshToken)
            XCTAssertNotNil(self?.tokenStorage.accessToken)
        }
    }
    
    func testTokenShouldNotBeSavedWhenSignUpFailed() {
        deleteTokens()
        let error = APIError(code: .passwordValidationError, message: "")
        client.result = .failure(error)
        
        authorizationService?.signUpWithEmail(userCredentials: userCredentials) { [weak self] _ in
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
