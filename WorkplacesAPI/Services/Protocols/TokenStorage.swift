//
//  TokenStorage.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 04.05.2021.
//

public protocol TokenStorage: AnyObject {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}
