//
//  APIConstants.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.06.2021.
//

public enum APIConstants {
    /// Временные интервалы между повторными запросами.
    public static let retryDelays: [TimeInterval] = [1, 2, 4, 10, 15]
}
