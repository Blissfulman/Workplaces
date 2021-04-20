//
//  User.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import Foundation

struct User {
    var name: String?
    var login: String?
    var email: String?
    var birthday: Date?
    var city: String?
    
    init(name: String? = nil, login: String? = nil, email: String? = nil, birthday: Date? = nil, city: String? = nil) {
        self.name = name
        self.login = login
        self.email = email
        self.birthday = birthday
        self.city = city
    }
}
