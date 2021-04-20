//
//  ErrorViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 18.04.2021.
//

import UIKit

// MARK: - Protocols

protocol ErrorScreenCoordinable {
    var didTapRefreshButton: VoidBlock? { get set }
}

final class ErrorViewController: UIViewController, ErrorScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapRefreshButton: VoidBlock?
    
    @IBAction private func refreshButtonTapped() {
        didTapRefreshButton?()
    }
}
