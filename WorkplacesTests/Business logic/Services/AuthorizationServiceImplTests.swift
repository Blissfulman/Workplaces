//
//  AuthorizationServiceImplTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

@testable import Workplaces
import WorkplacesAPI
import XCTest

final class AuthorizationServiceImplTests: XCTestCase {
    
    private var authorizationService: AuthorizationService?
    private var authDataStorage: AuthDataStorage?
    
    override func setUp() {
        super.setUp()
        let authDataStorage = AuthDataStorageMock(storage: UserDefaults(suiteName: "Test UserDefaults")!)
        
        authorizationService = AuthorizationServiceImpl(
            apiClient: ServiceLayer.shared.apiClient,
            authDataStorage: authDataStorage
        )
        self.authDataStorage = authDataStorage
    }

    override func tearDown() {
        authDataStorage?.deleteAuthData()
        super.tearDown()
    }
    
    func testSavingAuthorizationDataToAuthDataStorageAfterSuccessfulSignIn() {
        XCTAssertNil(authDataStorage?.accessToken)
        
        let expectation = expectation(description: "SignIn test")
        
        // Временно захардкодил авторизационные данные. Пытался реализовать stub клиента, не получилось
        let userCredentials = UserCredentials(email: "1@1.ru", password: "Qwerty12")
        authorizationService?.signIn(userCredentials: userCredentials) { [weak self] _ in
            XCTAssertNotNil(self?.authDataStorage?.accessToken)
            XCTAssertNotNil(self?.authDataStorage?.refreshToken)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
