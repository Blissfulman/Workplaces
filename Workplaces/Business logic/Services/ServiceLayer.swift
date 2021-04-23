//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

// MARK: - Protocols

protocol ServiceLayerProtocol {
    /// Сервис авторизации.
    var authorizationService: AuthorizationService { get }
}

final class ServiceLayer: ServiceLayerProtocol {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    let authorizationService: AuthorizationService = AuthorizationServiceImpl()
    
    // MARK: - Initializers
    
    private init() {}
}
