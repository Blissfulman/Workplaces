//
//  SignInDoneViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.04.2021.
//

import UIKit

// MARK: - Protocols

protocol SignInDoneScreenDelegate: AnyObject {
    func goToFeed()
}

final class SignInDoneViewController: BaseViewController {
    
    // MARK: - Private properties
    
    private weak var delegate: SignInDoneScreenDelegate?
    
    // MARK: - Initializers
    
    init(delegate: SignInDoneScreenDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    
    @IBOutlet private var imageView: UIImageView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func goToFeedButtonTapped() {
        delegate?.goToFeed()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut, .autoreverse, .repeat]) {
            self.imageView.transform.ty -= 10
        }
    }
}
