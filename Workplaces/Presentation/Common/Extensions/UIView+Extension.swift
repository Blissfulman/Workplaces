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
}
