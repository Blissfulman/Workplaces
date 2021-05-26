//
//  PublishPostEndpoint.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Alamofire
import Apexy

public struct PublishPostEndpoint: JsonEndpoint {
    
    // MARK: - Typealiases
    
    public typealias Content = Post
    
    // MARK: - Private properties
    
    private let uploadPost: UploadPost
    
    // MARK: - Initializers
    
    public init(post: Post) {
        self.uploadPost = UploadPost(post: post)
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        let multipartFormData = MultipartFormData()
        
        multipartFormData.append(uploadPost.text.data(using: .utf8) ?? Data(), withName: "text")
        multipartFormData.append(
            uploadPost.imageFile.data(using: .utf8) ?? Data(),
            withName: "image_file",
            fileName: "image.png"
        )
        multipartFormData.append(uploadPost.longitude.data(using: .utf8) ?? Data(), withName: "lon")
        multipartFormData.append(uploadPost.latitude.data(using: .utf8) ?? Data(), withName: "lat")
        
        return post(
            URL(string: "me/posts")!,
            body: .multipart(try multipartFormData.encode(), boundary: multipartFormData.boundary)
        )
    }
}
