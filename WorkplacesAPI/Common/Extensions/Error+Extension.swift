//
//  Error+Extension.swift
//  WorkplacesAPI
//
//  Created by Evgeny Novgorodov on 01.06.2021.
//

extension Error {
    
    /// Разворачивает ошибку валидации из Alamofire.
    func unwrapAFError() -> Error {
        guard let afError = asAFError else { return self }
        if case .responseValidationFailed(let reason) = afError,
           case .customValidationFailed(let underlyingError) = reason {
            return underlyingError
        }
        return self
    }
}
