//
//  ProtectionCoordinatingController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

import UIKit

final class ProtectionCoordinatingController: BaseViewController, Coordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private var protectionModel: ProtectionModel!
    private let tokenRefreshService: TokenRefreshService
    private let securityManager: SecurityManager
    private lazy var protectionVC = ProtectionViewController(protectionModel: protectionModel, delegate: self)
    
    // MARK: - Initializers
    
    init(
        tokenRefreshService: TokenRefreshService = ServiceLayer.shared.tokenRefreshService,
        securityManager: SecurityManager = ServiceLayer.shared.securityManager,
        onFinish: @escaping VoidBlock
    ) {
        self.tokenRefreshService = tokenRefreshService
        self.securityManager = securityManager
        self.onFinish = onFinish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func start() {
        // Создание модели необходимо сделать перед вызовом метода setupUI
        createProtectionModel()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func createProtectionModel() {
        let isInstalledProtection = securityManager.isSavedRefreshToken
        protectionModel = ProtectionModel(state: isInstalledProtection ? .protectionInstalled : .protectionNotInstalled)
    }
    
    private func setupUI() {
        addFullover(protectionVC)
    }
    
    private func trySaveRefreshTokenWithPassword() {
        if let token = securityManager.refreshToken {
            if securityManager.saveRefreshTokenWithPassword(token: token, password: protectionModel.password) {
                securityManager.isAuthorized = true
                onFinish()
            }
        }
    }
    
    private func tryEnterWithPassword() {
        protectionModel.attemptCount += 1
        
        if let refreshToken = securityManager.getRefreshTokenWithPassword(protectionModel.password) {
            protectionModel.attemptCount = 0
            securityManager.refreshToken = refreshToken
            refreshTokens(withToken: refreshToken)
        } else {
            protectionVC.indicateToWrongPassword { [weak self] in
                guard let self = self else { return }
                if self.protectionModel.needLogOut {
                    self.logOut()
                }
            }
        }
    }
    
    private func refreshTokens(withToken token: String) {
        tokenRefreshService.refreshTokens { [weak self] result in
            switch result {
            case .success:
                self?.securityManager.isAuthorized = true
                self?.onFinish()
            case let .failure(error):
                self?.showAlert(error: error)
            }
        }
    }
}

// MARK: - ProtectionViewControllerDelegate

extension ProtectionCoordinatingController: ProtectionViewControllerDelegate {
    
    func logOut() {
        securityManager.logoutReset()
        onFinish()
    }
    
    func didTapFingerprintButton() {
        // Необходимо доработать
    }
    
    func didEnterPassword() {
        protectionModel.state == .protectionInstalled ? tryEnterWithPassword() : trySaveRefreshTokenWithPassword()
    }
}
