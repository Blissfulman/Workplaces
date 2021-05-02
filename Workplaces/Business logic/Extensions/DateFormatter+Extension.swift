//
//  DateFormatter+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 03.05.2021.
//

import Foundation

extension DateFormatter {
    
    static let profileDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
}
