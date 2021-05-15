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
    
    /// Анимация масштабирования.
    /// - Parameters:
    ///   - duration: Длительность анимации (по умолчанию равна `0.15`).
    ///   - delay: Задержка перед началом анимации (по умолчанию равна `0`).
    ///   - scale: Коэффициент масштабирования (по умолчанию равен `0.98`).
    ///   - completion: Обработчик, выполняемый после завершения анимации.
    func scaleAnimation(
        duration: TimeInterval = 0.15,
        delay: TimeInterval = 0,
        scale: CGFloat = 0.98,
        completion: @escaping VoidBlock
    ) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut, .autoreverse]) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { isDone in
            if isDone {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                completion()
            }
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
