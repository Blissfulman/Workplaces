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
    /// - Parameter duration: Длительность анимации (по умолчанию равна `0.4`).
    func shakeAnimation(duration: TimeInterval = 0.4) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, 10, -10, 10, -5, 5, -5, 0]
        shakeAnimation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.8, 1]
        shakeAnimation.duration = duration
        shakeAnimation.isAdditive = true
        layer.add(shakeAnimation, forKey: "shake")
    }
    
    /// Анимация плавного появления.
    /// - Parameters:
    ///   - fromValue: Изначальное значение параметра `alpha` (по умолчанию равно `0`).
    ///   - toValue: Конечное значение параметра `alpha` (по умолчанию равно `1`).
    ///   - duration: Длительность анимации (по умолчанию равна `0.4`).
    func appear(fromValue: CGFloat = 0, toValue: CGFloat = 1, duration: Double = 0.4) {
        isHidden = false
        alpha = fromValue
        UIView.animate(withDuration: duration) {
            self.alpha = toValue
        } completion: { isEnded in
            if isEnded {
                self.alpha = toValue
            }
        }
    }
    
    /// Анимация плавного исчезновения.
    /// - Parameters:
    ///   - fromValue: Изначальное значение параметра `alpha` (по умолчанию равно `1`).
    ///   - toValue: Конечное значение параметра `alpha` (по умолчанию равно `0`).
    ///   - duration: Длительность анимации (по умолчанию равна `0.4`).
    func disappear(fromValue: CGFloat = 1, toValue: CGFloat = 0, duration: Double = 0.4) {
        alpha = fromValue
        UIView.animate(withDuration: duration) {
            self.alpha = toValue
        } completion: { isEnded in
            if isEnded {
                self.alpha = toValue
                self.isHidden = true
            }
        }
    }
}
