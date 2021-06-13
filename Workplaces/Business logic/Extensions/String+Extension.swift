//
//  String+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.05.2021.
//

import Foundation

extension String {
    
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
    
    func localizedWithValue(_ value: String) -> String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: value, comment: "")
    }
}
