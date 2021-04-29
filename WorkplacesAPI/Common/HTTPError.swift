//
//  HTTPError.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 26.04.2021.
//

struct HTTPError: Error {
    
    let statusCode: Int
    let url: URL?
    
    var localizedDescription: String {
        HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }
}

// MARK: - CustomNSError

extension HTTPError: CustomNSError {
    
    static var errorDomain = "Workplaces.HTTPErrorDomain"
    
    public var errorCode: Int { statusCode }
    
    public var errorUserInfo: [String: Any] {
        var userInfo: [String: Any] = [NSLocalizedDescriptionKey: localizedDescription]
        userInfo[NSURLErrorKey] = url
        return userInfo
    }
}
