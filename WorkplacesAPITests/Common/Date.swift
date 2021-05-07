//
//  Date.swift
//  WorkplacesAPITests
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

import Foundation

extension Date {
    
    static func makeDate(year: Int, month: Int, day: Int) -> Self {
        DateComponents(
            calendar: .current,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: year,
            month: month,
            day: day
        ).date!
    }
}
