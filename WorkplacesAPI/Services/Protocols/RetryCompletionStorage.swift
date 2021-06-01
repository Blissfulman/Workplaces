//
//  RetryCompletionStorage.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.06.2021.
//

public protocol RetryCompletionStorage {
    
    /// Получение состояния прогресса обновления токена.
    func getProgressState() -> Bool
    
    /// Переключение состояния прогресса обновления токена.
    /// - Parameter state: Новое состояние.
    func switchProgress(to state: Bool)
    
    /// Добавление комплишен в хранилище.
    /// - Parameter completion: Комплишен.
    func add(completion: @escaping RetryCompletion)
    
    /// Извлекает комплишены из хранилища (не оставляя их в нём).
    func extractCompletions() -> [RetryCompletion]
}
