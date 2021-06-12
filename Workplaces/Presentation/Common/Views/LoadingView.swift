//
//  LoadingView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

final class LoadingView {
    
    // MARK: - Static properties
    
    private static var backView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .clear
        view.addSubview(activityIndicator)
        return view
    }()
    
    private static var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        activityIndicator.style = .large
        activityIndicator.backgroundColor = Palette.darkGrey.withAlphaComponent(0.3)
        activityIndicator.color = Palette.white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.setCornerRadius(25)
        return activityIndicator
    }()
    
    // MARK: - Static methods
    
    static func show() {
        DispatchQueue.main.async {
            setup()
            activityIndicator.startAnimating()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            backView.removeFromSuperview()
        }
    }
    
    private static func setup() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        window.addSubview(backView)
    }
}
