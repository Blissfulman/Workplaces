//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

// MARK: - Protocols

protocol ServiceLayerProtocol {
    /// Сервис авторизации.
    var authorizationService: AuthorizationServiceProtocol { get }
}

final class ServiceLayer: ServiceLayerProtocol {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    let authorizationService: AuthorizationServiceProtocol = AuthorizationService()
    
    // MARK: - Initializers
    
    private init() {}
}
