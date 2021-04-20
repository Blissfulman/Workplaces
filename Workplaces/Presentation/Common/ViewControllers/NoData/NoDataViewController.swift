//
//  NoDataViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 18.04.2021.
//

import UIKit

// MARK: - Protocols

protocol NoDataScreenCoordinable {
    var didTapCreatePostButton: VoidBlock? { get set }
}

final class NoDataViewController: UIViewController, NoDataScreenCoordinable {
    
    // MARK: - Public properties
    
    var didTapCreatePostButton: VoidBlock?
    
    @IBAction private func createPostButtonTapped() {
        didTapCreatePostButton?()
    }
}
