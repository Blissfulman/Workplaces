//
//  ServiceLayer.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

// MARK: - Protocols

protocol ServiceLayerProtocol {
    var authorizationService: AuthorizationServiceProtocol { get }
}

final class ServiceLayer: ServiceLayerProtocol {
    
    // MARK: - Static properties
    
    static let shared = ServiceLayer()
    
    // MARK: - Public properties
    
    let authorizationService: AuthorizationServiceProtocol
    
    // MARK: - Initializers
    
    private init(authorizationService: AuthorizationServiceProtocol = AuthorizationService()) {
        self.authorizationService = authorizationService
    }
    
    // MARK: - Public methods
}
