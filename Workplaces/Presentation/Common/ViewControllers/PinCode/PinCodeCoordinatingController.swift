//
//  PinCodeCoordinatingController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.06.2021.
//

import UIKit
import WorkplacesAPI

final class PinCodeCoordinatingController: BaseViewController, Coordinator {
    
    // MARK: - Public properties
    
    var onFinish: VoidBlock
    
    // MARK: - Private properties
    
    private let tokenStorage: TokenStorage
    private var pinCodeModel: PinCodeModel!
    private lazy var pinCodeVC = PinCodeViewController(pinCodeModel: pinCodeModel, delegate: self)
    
    // MARK: - Initializers
    
    init(tokenStorage: TokenStorage = ServiceLayer.shared.tokenStorage, onFinish: @escaping VoidBlock) {
        self.tokenStorage = tokenStorage
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
        let isInstalledProtection = tokenStorage.refreshToken != nil
        print(isInstalledProtection ? "Done" : "Need new") // TEMP
        pinCodeModel = PinCodeModel(state: isInstalledProtection ? .protectionInstalled : .protectionNotInstalled)
    }
    
    private func setupUI() {
        addFullover(pinCodeVC)
    }
}

// MARK: - PinCodeViewControllerDelegate

extension PinCodeCoordinatingController: PinCodeViewControllerDelegate {
    
    func logOut() {
        tokenStorage.refreshToken = nil
        tokenStorage.temporaryRefreshToken = nil
        tokenStorage.isEnteredPinCode = false
        onFinish()
    }
    
    func successfulPinCodeSetup() {
        if let refreshToken = tokenStorage.temporaryRefreshToken {
            tokenStorage.refreshToken = refreshToken
            tokenStorage.temporaryRefreshToken = nil
        }
        tokenStorage.isEnteredPinCode = true
        onFinish()
    }
    
    func needCheckPassword() {
        
    }
}
