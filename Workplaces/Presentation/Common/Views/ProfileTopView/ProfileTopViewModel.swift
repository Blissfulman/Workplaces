//
//  ProfileTopViewModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 23.05.2021.
//

import Foundation

struct ProfileTopViewModel {
    
    // MARK: - Public properties
    
    var avatarImageData: Data? {
        // Временная реализация получения картинки
        guard let avatarURL = profile.avatarURL,
              let data = try? Data(contentsOf: avatarURL),
              let imageData = Data(base64Encoded: data) else { return nil }
        return imageData
    }
    var fullName: String {
        "\(profile.firstName) \(profile.lastName)"
    }
    var age: String? {
        let age = profile.birthday.getAgeFromBirthday()
        var resultStringAge = "\(age) "
        switch age.getRussianTypeOfYear() {
        case .one:
            resultStringAge += "Year-One".localizedWithValue("year")
        case .oneLast:
            resultStringAge += "Year-OneLast".localizedWithValue("years")
        case .several:
            resultStringAge += "Year-Several".localizedWithValue("years")
        case .other:
            resultStringAge += "Year-Other".localizedWithValue("years")
        }
        return resultStringAge
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
}
