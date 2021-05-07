//
//  AuthorizationData.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

public struct AuthorizationData: Codable {
    
    public let accessToken: String
    public let refreshToken: String
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

public extension AuthorizationData {
    
    /// Возвращает экземпляр `AuthorizationData` для тестов.
    static func testAuthorizationData() -> Self {
        AuthorizationData(
            accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM",
            refreshToken: "8feed535-5ca5-464e-862d-0de124800aa3"
        )
    }
}
