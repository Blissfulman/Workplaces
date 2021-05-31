//
//  RetryCompletionStorage.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 31.05.2021.
//

import Alamofire

// MARK: - Typealiases

typealias RetryCompletion = (RetryResult) -> Void

/// Потокобезопасное хранилище для объектов `RetryCompletion` и статуса обновления токена.
class RetryCompletionStorage {
    
    // MARK: - Private properties
    
    private let queue = DispatchQueue(label: "RetryCompletionStorage.queue")
    private var isInProgressRefreshingToken = false
    private var completions = [RetryCompletion]()
    
    // MARK: - Public methods
    
    func getProgressState() -> Bool {
        queue.sync { isInProgressRefreshingToken }
    }
    
    func switchProgress(to state: Bool) {
        queue.sync { isInProgressRefreshingToken = state }
    }
    
    func add(completion: @escaping RetryCompletion) {
        queue.sync { completions.append(completion) }
    }
    
    func getCompletions() -> [RetryCompletion] {
        queue.sync {
            let result = completions
            completions = []
            return result
        }
    }
}
