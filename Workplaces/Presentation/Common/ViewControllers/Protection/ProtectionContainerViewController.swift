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
    
    private lazy var protectionModel = ProtectionModel(isSetProtection: securityManager.isSavedRefreshToken)
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
        setupUI()
    }
    
    // MARK: - Private methods
    
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
        securityManager.remainingEntryAttemptsCount -= 1
        protectionModel.remainingEntryAttemptsCount = securityManager.remainingEntryAttemptsCount
        
        if let refreshToken = securityManager.getRefreshTokenWithPassword(protectionModel.password) {
            securityManager.refreshToken = refreshToken
            refreshTokens(withToken: refreshToken)
        } else {
            protectionVC.indicateToWrongPassword { [weak self] in
                guard let self = self else { return }
                if self.protectionModel.isNeedLogOut {
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
        // Необходимо доработать (из-за отсутствия реального устройства оставил без реализации)
        showAlert(title: "Not available".localized(), message: "Functionality is under development".localized())
    }
    
    func didEnterPassword() {
        protectionModel.isSetProtection ? tryEnterWithPassword() : trySaveRefreshTokenWithPassword()
    }
}
