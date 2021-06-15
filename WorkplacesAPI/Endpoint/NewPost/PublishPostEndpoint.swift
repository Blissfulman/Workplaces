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
    
    public init(uploadPost: UploadPost) {
        self.uploadPost = uploadPost
    }
    
    // MARK: - Public methods
    
    public func makeRequest() throws -> URLRequest {
        let multipartFormData = MultipartFormData()
        
        multipartFormData.append(uploadPost.text.data(using: .utf8) ?? Data(), withName: "text")
        if let imageFileURL = uploadPost.imageFileURL {
            multipartFormData.append(imageFileURL, withName: "image_file")
        }
        if let location = uploadPost.location {
            multipartFormData.append(
                String(describing: location.longitude).data(using: .utf8) ?? Data(), withName: "lon"
            )
            multipartFormData.append(
                String(describing: location.latitude).data(using: .utf8) ?? Data(), withName: "lat"
            )
        }
        
        return post(
            URL(string: "me/posts")!,
            body: .multipart(try multipartFormData.encode(), boundary: multipartFormData.boundary)
        )
    }
}
