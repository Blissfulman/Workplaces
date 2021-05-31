//
//  UpdateMyProfileEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire
import Apexy

public struct UpdateMyProfileEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = User
    
    // MARK: - Private properties
    
    private let uploadUser: UploadUser
    
    // MARK: - Initializers
    
    public init(user: User) {
        self.uploadUser = UploadUser(user: user)
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        let multipartFormData = MultipartFormData(fileManager: FileManager(), boundary: MultipartFormData().boundary)
        
        multipartFormData.append(uploadUser.firstName.data(using: .utf8) ?? Data(), withName: "first_name")
        multipartFormData.append(uploadUser.lastName.data(using: .utf8) ?? Data(), withName: "last_name")
        multipartFormData.append(uploadUser.nickname.data(using: .utf8) ?? Data(), withName: "nickname")
        multipartFormData.append(
            uploadUser.avatarFile.data(using: .utf8, allowLossyConversion: false) ?? Data(),
            withName: "avatar_file",
            fileName: "avatar.jpg"
        )
        multipartFormData.append(uploadUser.birthday.data(using: .utf8) ?? Data(), withName: "birth_day")

        return patch(
            URL(string: "me")!,
            body: .multipart(try multipartFormData.encode(), boundary: multipartFormData.boundary)
        )
    }
}
