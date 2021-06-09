//
//  PinCodeCoordinatingController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

import UIKit

final class PinCodeCoordinatingController: BaseViewController, Coordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private var pinCodeModel: PinCodeModel!
    private let tokenRefreshService: TokenRefreshService
    private let securityManager: SecurityManager
    private lazy var pinCodeVC = PinCodeViewController(pinCodeModel: pinCodeModel, delegate: self)
    private var attemptCount = 0
    private let maxAttemptCount = 5
    
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
        createPinCodeModel()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func createPinCodeModel() {
        let isInstalledProtection = securityManager.protectionState != .none
        pinCodeModel = PinCodeModel(state: isInstalledProtection ? .protectionInstalled : .protectionNotInstalled)
    }
    
    private func setupUI() {
        addFullover(pinCodeVC)
    }
    
    private func trySaveRefreshTokenWithPassword() {
        if let token = securityManager.refreshToken {
            if securityManager.saveRefreshTokenWithPassword(token: token, password: pinCodeModel.password) {
                securityManager.isAuthorized = true
                securityManager.protectionState = .passwordProtected
                onFinish()
            }
        }
    }
    
    private func tryEnterWithPassword() {
        attemptCount += 1
        let attemptsRemaining = maxAttemptCount - attemptCount
        
        if let refreshToken = securityManager.getRefreshTokenWithPassword(pinCodeModel.password) {
            securityManager.refreshToken = refreshToken
            securityManager.isAuthorized = true
            refreshTokens(withToken: refreshToken)
        } else {
            pinCodeVC.indicateToWrongPassword(attemptsRemaining: attemptsRemaining) { [weak self] in
                if attemptsRemaining == 0 {
                    self?.logOut()
                }
            }
        }
    }
    
    private func refreshTokens(withToken token: String) {
        tokenRefreshService.refreshTokens { [weak self] result in
            switch result {
            case .success:
                self?.onFinish()
            case let .failure(error):
                self?.showAlert(error: error)
            }
        }
    }
}

// MARK: - PinCodeViewControllerDelegate

extension PinCodeCoordinatingController: PinCodeViewControllerDelegate {
    
    func logOut() {
        securityManager.logoutReset()
        onFinish()
    }
    
    func didTapFingerprintButton() {
        // Необходимо доработать
    }
    
    func didEnterPassword() {
        #if targetEnvironment(simulator)
        pinCodeModel.state == .protectionInstalled ? tryEnterWithPassword() : trySaveRefreshTokenWithPassword()
        #else
        pinCodeModel.state == .protectionInstalled ? tryEnterWithPassword() : trySaveRefreshTokenWithPassword()
        #endif
    }
}
