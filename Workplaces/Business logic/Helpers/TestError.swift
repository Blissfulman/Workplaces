//
//  TestError.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 02.05.2021.
//

import Foundation

// Временная ошибка для тестов

enum TestError: Error, LocalizedError {
    case error
    
    var errorDescription: String? {
        "Тестовая ошибка"
    }
}
