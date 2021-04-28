//
//  AuthorizationData.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

public struct AuthorizationData: Codable {
    public let accessToken: String
    public let refreshToken: String
}
