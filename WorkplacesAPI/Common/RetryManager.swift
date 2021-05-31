//
//  RetryManager.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 31.05.2021.
//

import Alamofire

// MARK: - Typealiases

typealias RetryCompletion = (RetryResult) -> Void

final class RetryManager {
    
}

struct RetryCompletionStorage {
    
    private let queue = DispatchQueue(label: "RetryCompletionStorage.queue")
    private var isInProgressRefreshingToken = false
    private var completions = [RetryCompletion]()
    
    func getProgressState() -> Bool {
        queue.sync { isInProgressRefreshingToken }
    }
    
    mutating func switchProgress(to state: Bool) {
        queue.sync { isInProgressRefreshingToken = state }
    }
    
    mutating func add(completion: @escaping RetryCompletion) {
        queue.sync { completions.append(completion) }
    }
    
    mutating func getCompletions() -> [RetryCompletion] {
        queue.sync {
            let result = completions
            completions = []
            return result
        }
    }
}
