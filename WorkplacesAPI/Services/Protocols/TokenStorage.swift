//
//  TokenStorage.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 04.05.2021.
//

public protocol TokenStorage: AnyObject {
    static var refreshTokenTemp: String? { get set }
    var isEnteredPinCode: Bool { get set }
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}
