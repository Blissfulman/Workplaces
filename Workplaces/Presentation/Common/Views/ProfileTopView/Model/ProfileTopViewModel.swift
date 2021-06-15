//
//  ProfileTopViewModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 23.05.2021.
//

import Foundation

struct ProfileTopViewModel {
    
    // MARK: - Public properties
    
    var fullName: String {
        "\(profile.firstName) \(profile.lastName)"
    }
    var age: String? {
        let age = profile.birthday.getAgeFromBirthday()
        return "\(age) " + age.getRussianTypeOfYear().localized
    }
    
    // MARK: - Private properties
    
    let profile: User
}

// MARK: - Extensions

fileprivate extension Date {
    
    func getAgeFromBirthday() -> Int {
        max(0, Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0)
    }
}

fileprivate extension Int {
    
    func getRussianTypeOfYear() -> RussianTypeOfYear {
        if self == 1 { return .one }
        
        switch self % 10 {
        case 1 where (self % 100 != 11):
            return .oneLast
        case 2...4 where (!(11...14).contains(self % 100)):
            return .several
        default:
            return .other
        }
    }
}

/// Необходим для правильного соотнесения со словами "год", "года" и "лет"  в русской локализации.
private enum RussianTypeOfYear: String {
    
    case one        // 1 год
    case oneLast    // (оканчивающиеся на 1, кроме оканчивающихся на 11) год
    case several    // (оканчивающиеся на 2...4, кроме оканчивающихся на 12..14) года
    case other      // (все остальные) лет
    
    var localized: String {
        switch self {
        case .one:
            return "Year-One".localizedWithValue("year")
        case .oneLast:
            return "Year-OneLast".localizedWithValue("years")
        case .several:
            return "Year-Several".localizedWithValue("years")
        case .other:
            return "Year-Other".localizedWithValue("years")
        }
    }
}
