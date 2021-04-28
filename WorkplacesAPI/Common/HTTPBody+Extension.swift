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
    /// - Returns: HTTPBody.
    static func multipart(_ data: Data) -> HTTPBody {
        // Необходимо добавить реализацию
        HTTPBody(data: data, contentType: "multipart/form-data")
    }
}
