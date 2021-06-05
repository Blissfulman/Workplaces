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
    private let pinCodeModel = PinCodeModel()
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
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Public methods
    
    func start() {
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        addFullover(pinCodeVC)
    }
}

// MARK: - PinCodeViewControllerDelegate

extension PinCodeCoordinatingController: PinCodeViewControllerDelegate {
    
    func successfulPinCodeSetup() {
        if let refreshToken = TokenStorageImpl.refreshTokenTemp {
            tokenStorage.refreshToken = refreshToken
        }
        tokenStorage.isEnteredPinCode = true
        onFinish()
    }
    
    func logOut() {
        tokenStorage.refreshToken = nil
        tokenStorage.isEnteredPinCode = false
        onFinish()
    }
}
