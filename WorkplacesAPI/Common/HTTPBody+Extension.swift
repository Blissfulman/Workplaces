//
//  HTTPBody+Extension.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import Apexy

extension HTTPBody {
    
    /// Create HTTP body with multipart content type.
    ///
    /// - Parameters:
    ///   - data: HTTP body data.
    ///   - boundary: Значение boundary.
    /// - Returns: HTTPBody.
    static func multipart(_ data: Data, boundary: String) -> HTTPBody {
        HTTPBody(data: data, contentType: "multipart/form-data; boundary=\(boundary)")
    }
}
