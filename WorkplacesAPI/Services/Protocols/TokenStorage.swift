//
//  TokenStorage.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 04.05.2021.
//

public protocol TokenStorage {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    func saveAuthData(_ data: AuthorizationData)
    func deleteAuthData()
}
