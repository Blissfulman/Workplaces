//
//  TimeManager.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.06.2021.
//

protocol TimeManager {
    /// Сохранить текущее время.
    func saveTime()
    /// Получить интервал времени между текущим и последним сохранённым временем (в секундах).
    func getElapsedTime() -> Int
}
