//
//  HTTPError.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

import Foundation

struct HTTPError: Error {
    let statusCode: Int
    let url: URL?

    var localizedDescription: String {
        return HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }
}

// MARK: - CustomNSError

extension HTTPError: CustomNSError {
    static var errorDomain = "Example.HTTPErrorDomain"

    public var errorCode: Int { return statusCode }

    public var errorUserInfo: [String: Any] {
        var userInfo: [String: Any] = [NSLocalizedDescriptionKey: localizedDescription]
        userInfo[NSURLErrorKey] = url
        return userInfo
    }
}
