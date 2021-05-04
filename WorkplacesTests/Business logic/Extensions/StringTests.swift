//
//  StringTests.swift
//  WorkplacesTests
//
//  Created by Evgeny Novgorodov on 04.05.2021.
//

@testable import Workplaces
import XCTest

final class StringTests: XCTestCase {

    func testEmailValidationShouldBeSuccess() {
        let email = "test@test.ru"
        XCTAssertTrue(email.isValidEmail())
    }
    
    func testEmptyEmailValidationShouldBeFail() {
        let email = ""
        XCTAssertFalse(email.isValidEmail())
    }
}
