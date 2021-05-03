//
//  UserTests.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

import WorkplacesAPI
import XCTest

final class UserTests: XCTestCase {

    func testDecoding() throws {
        let jsonData = """
            {
                "id": "8feed535-5ca5-464e-862d-0de124800aa3",
                "first_name": "Martin",
                "last_name": "Fowler",
                "nickname": "RefactorMan",
                "avatar_url": "https://redmadrobot.com/",
                "birth_day": "2021-12-21"
            }
            """.data(using: .utf8)!
        
        let user = try JSONDecoder.default.decode(User.self, from: jsonData)
        
        XCTAssertEqual(user.birthday, makeDate(year: 2021, month: 12, day: 21))
    }

    private func makeDate(year: Int, month: Int, day: Int) -> Date {
        DateComponents(
            calendar: .current,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: year,
            month: month,
            day: day
        ).date!
    }
}
