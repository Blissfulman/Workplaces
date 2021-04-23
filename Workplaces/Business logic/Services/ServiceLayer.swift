//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

final class ServiceLayer {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    lazy var authorizationService: AuthorizationService = AuthorizationServiceImpl()
    
    // MARK: - Initializers
    
    private init() {}
}
