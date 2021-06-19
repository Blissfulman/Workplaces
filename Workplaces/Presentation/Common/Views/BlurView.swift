//
//  BlurView.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.06.2021.
//

import UIKit

final class BlurView {
    
    // MARK: - Static properties
    
    private static var blurView: UIView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.main.bounds
        return blurView
    }()
    
    // MARK: - Static methods
    
    static func show() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        window.addSubview(blurView)
    }
    
    static func hide() {
        blurView.removeFromSuperview()
    }
}
