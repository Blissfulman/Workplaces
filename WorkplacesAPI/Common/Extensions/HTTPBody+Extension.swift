//
//  HTTPBody+Extension.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 28.04.2021.
//

import Apexy

extension HTTPBody {
    
    /// Создаёт HTTP body для контента типа "multipart/form-data".
    ///
    /// - Parameters:
    ///   - data: Данные для HTTP body.
    ///   - boundary: Значение boundary.
    /// - Returns: Возвращает `HTTPBody`.
    static func multipart(_ data: Data, boundary: String) -> HTTPBody {
        HTTPBody(data: data, contentType: "multipart/form-data; boundary=\(boundary)")
    }
}
