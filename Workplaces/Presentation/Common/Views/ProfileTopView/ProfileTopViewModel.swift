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
        guard let age = profile.birthday.getAgeFromBirthday() else { return nil }
        return "\(age) years"
    }
    
    // MARK: - Private properties
    
    let profile: User
}

// MARK: - Extensions

fileprivate extension Date {
    
    func getAgeFromBirthday() -> Int? {
        Calendar.current.dateComponents([.year], from: self, to: Date()).year
    }
}
