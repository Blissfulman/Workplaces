//
//  RetryCompletionStorageImpl.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 31.05.2021.
//

import Alamofire

// MARK: - Typealiases

public typealias RetryCompletion = (RetryResult) -> Void

/// Потокобезопасное хранилище для объектов `RetryCompletion` и статуса обновления токена.
public final class RetryCompletionStorageImpl: RetryCompletionStorage {
    
    // MARK: - Private properties
    
    private let queue = DispatchQueue(label: "RetryCompletionStorage.queue")
    private var isInProgressRefreshingToken = false
    private var completions = [RetryCompletion]()
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getProgressState() -> Bool {
        queue.sync { isInProgressRefreshingToken }
    }
    
    public func switchProgress(to state: Bool) {
        queue.sync { isInProgressRefreshingToken = state }
    }
    
    public func add(completion: @escaping RetryCompletion) {
        queue.sync { completions.append(completion) }
    }
    
    public func getCompletions() -> [RetryCompletion] {
        queue.sync {
            let result = completions
            completions = []
            return result
        }
    }
}
