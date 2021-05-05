//
//  StringTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 04.05.2021.
//

@testable import Workplaces
import XCTest

final class StringValidatorTests: XCTestCase {

    func testEmailValidationShouldBeSuccess() {
        let email = "test@test.ru"
        XCTAssertTrue(StringValidator.isValidEmail(email))
    }
    
    func testEmptyEmailValidationShouldBeFail() {
        let email = ""
        XCTAssertFalse(StringValidator.isValidEmail(email))
    }
}
