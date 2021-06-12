//
//  ProtectionContaiterViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

import UIKit

// MARK: - Protocols

protocol ProtectionContainerViewControllerDelegate: AnyObject {
    func didCancelSetUpProtection()
    func didSetProtection()
    func didPassProtectionCheck()
}

final class ProtectionContainerViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private var protectionModel: ProtectionModel!
    private let tokenRefreshService: TokenRefreshService
    private let securityManager: SecurityManager
    private var progressList = [Progress]()
    private weak var delegate: ProtectionContainerViewControllerDelegate?
    private lazy var protectionVC = ProtectionViewController(protectionModel: protectionModel, delegate: self)
    
    // MARK: - Initializers
    
    init(
        tokenRefreshService: TokenRefreshService = ServiceLayer.shared.tokenRefreshService,
        securityManager: SecurityManager = ServiceLayer.shared.securityManager,
        delegate: ProtectionContainerViewControllerDelegate
    ) {
        self.tokenRefreshService = tokenRefreshService
        self.securityManager = securityManager
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    
    deinit {
        progressList.forEach { $0.cancel() }
    }
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        navigationController?.setNavigationBarHidden(true, animated: true)
        addFullover(protectionVC)
    }
    
    private func trySaveRefreshTokenWithPassword() {
        if let token = securityManager.refreshToken {
            if securityManager.saveRefreshTokenWithPassword(token: token, password: protectionModel.password) {
                securityManager.isAuthorized = true
                delegate?.didSetProtection()
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
                    self.didTapExitButton()
                }
            }
        }
    }
    
    private func refreshTokens(withToken token: String) {
        let progress = tokenRefreshService.refreshTokens { [weak self] result in
            switch result {
            case .success:
                self?.securityManager.isAuthorized = true
                self?.delegate?.didPassProtectionCheck()
            case let .failure(error):
                self?.showAlert(error: error)
            }
        }
        progressList.append(progress)
    }
}

// MARK: - ProtectionViewControllerDelegate

extension ProtectionContainerViewController: ProtectionViewControllerDelegate {
    
    func didTapExitButton() {
        securityManager.logoutReset()
        delegate?.didCancelSetUpProtection()
    }
    
    func didTapFingerprintButton() {
        // Необходимо доработать
    }
    
    func didEnterPassword() {
        protectionModel.state == .protectionInstalled ? tryEnterWithPassword() : trySaveRefreshTokenWithPassword()
    }
}
