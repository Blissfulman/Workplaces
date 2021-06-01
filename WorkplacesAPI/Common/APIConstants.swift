//
//  APIConstants.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.06.2021.
//

public enum APIConstants {
    /// Максимальное количество повторных запросов.
    public static let maxRetryCount = 5
    /// Временные интервалы между повторными запросами.
    public static let retryDelays: [Int: TimeInterval] = [0: 1, 1: 2, 2: 4, 3: 10, 4: 15]
}
