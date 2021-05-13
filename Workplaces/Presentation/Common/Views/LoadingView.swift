//
//  LoadingView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class LoadingView {
    
    // MARK: - Static properties
    
    static var activityIndicator = UIActivityIndicatorView(frame: UIScreen.main.bounds)
    
    // MARK: - Static methods
    
    static func show() {
        DispatchQueue.main.async {
            setup()
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    private static func setup() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        activityIndicator.backgroundColor = Palette.darkGrey.withAlphaComponent(0.5)
        activityIndicator.color = Palette.white
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        window.addSubview(activityIndicator)
    }
}
