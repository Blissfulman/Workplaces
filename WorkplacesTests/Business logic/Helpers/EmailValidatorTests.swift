//
//  EmailValidatorTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 04.05.2021.
//

@testable import Workplaces
import XCTest

final class EmailValidatorTests: XCTestCase {
    
    // MARK: - Public methods
    
    func testEmailValidationShouldBeSuccess() {
        let email = "test@test.ru"
        XCTAssertTrue(EmailValidator.isValid(email))
    }
    
    func testEmptyEmailValidationShouldBeFail() {
        let email = ""
        XCTAssertFalse(EmailValidator.isValid(email))
    }
}
