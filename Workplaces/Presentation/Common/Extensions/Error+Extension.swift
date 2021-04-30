//
//  Error+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 30.04.2021.
//

public extension Error {
    
    /// Метод нужен для того чтобы достать ошибку валидации из Alamofire.
    func unwrapAFError() -> Error {
        guard let afError = asAFError else { return self }
        if case .responseValidationFailed(let reason) = afError,
           case .customValidationFailed(let underlyingError) = reason {
            return underlyingError
        }
        return self
    }
}
