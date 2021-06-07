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
    private let securityManager: SecurityManager
    private lazy var pinCodeVC = PinCodeViewController(pinCodeModel: pinCodeModel, delegate: self)
    
    // MARK: - Initializers
    
    init(
        securityManager: SecurityManager = ServiceLayer.shared.securityManager,
        onFinish: @escaping VoidBlock
    ) {
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
}

// MARK: - PinCodeViewControllerDelegate

extension PinCodeCoordinatingController: PinCodeViewControllerDelegate {
    
    func logOut() {
        securityManager.isAuthorized = false
        securityManager.removeRefreshToken()
        securityManager.temporaryRefreshToken = nil
        onFinish()
    }
    
    func successfulPinCodeSetup() {
//        if let refreshToken = securityManager.temporaryRefreshToken {
//            _ = securityManager.saveRefreshTokenWithPassword(token: refreshToken, password: "")
//            securityManager.temporaryRefreshToken = nil
//            
//            securityManager.protectionState = .passwordProtected
//        }
//        onFinish()
    }
    
    func didEnterPassword() {
        #if targetEnvironment(simulator)
        if pinCodeModel.state == .protectionInstalled {
            let token = securityManager.getRefreshTokenWithPassword(pinCodeModel.password)
            print(token ?? "No token")
        } else {
            if let token = securityManager.temporaryRefreshToken {
                if securityManager.saveRefreshTokenWithPassword(token: token, password: pinCodeModel.password) {
                    securityManager.isAuthorized = true
                    securityManager.protectionState = .passwordProtected
                    onFinish()
                }
            }
        }
        #else
        if pinCodeModel.state == .protectionInstalled {
            let token = securityManager.getRefreshTokenWithPassword(pinCodeModel.password)
            print(token ?? "No token")
        }
        #endif
    }
}
