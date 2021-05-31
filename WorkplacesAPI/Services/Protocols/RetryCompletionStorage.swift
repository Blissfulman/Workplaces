//
//  RetryCompletionStorage.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.06.2021.
//

public protocol RetryCompletionStorage {
    func getProgressState() -> Bool
    func switchProgress(to state: Bool)
    func add(completion: @escaping RetryCompletion)
    func getCompletions() -> [RetryCompletion]
}
