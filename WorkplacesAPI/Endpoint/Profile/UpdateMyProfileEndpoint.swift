//
//  UpdateMyProfileEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Apexy

public struct UpdateMyProfileEndpoint: JsonEndpoint {
    
    public typealias Content = User
    
    private let uploadUser: UploadUser
    
    public init(user: User) {
        self.uploadUser = UploadUser(user: user)
    }
    
    public func makeRequest() throws -> URLRequest {
        patch(URL(string: "me")!, body: .multipart(try encoder.encode(uploadUser)))
    }
}
