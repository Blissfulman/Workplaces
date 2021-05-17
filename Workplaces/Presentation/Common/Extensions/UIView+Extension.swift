//
//  UIView+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 15.05.2021.
//

import UIKit

extension UIView {
    
    /// Устанавливает переданный радиус скругления углов.
    /// - Parameter value: Значение радиуса.
    func setCornerRadius(_ value: CGFloat) {
        layer.cornerCurve = .continuous
        layer.cornerRadius = value
    }
    
    /// Анимация уменьшения размера.
    /// - Parameters:
    ///   - duration: Длительность анимации (по умолчанию равна `0.08`).
    ///   - scale: Коэффициент масштабирования (по умолчанию равен `0.98`).
    func downscaleAnimation(duration: TimeInterval = 0.08, scale: CGFloat = 0.98) {
        UIView.animate(withDuration: duration, delay: 0, options: []) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    /// Анимация восстановления исходного размера.
    /// - Parameter duration: Длительность анимации (по умолчанию равна `0.08`).
    func resetScaleAnimation(duration: TimeInterval = 0.08) {
        UIView.animate(withDuration: duration, delay: 0, options: []) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    /// Анимация горизонтальной тряски.
    func shakeAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, 10, -10, 10, -5, 5, -5, 0]
        shakeAnimation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true
        layer.add(shakeAnimation, forKey: "shake")
    }
}
